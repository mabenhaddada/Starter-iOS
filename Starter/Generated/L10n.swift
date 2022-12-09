// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Button {
    /// comment
    internal static let cancel = L10n.tr("Localizable", "Button.Cancel", fallback: "Annuler")
    /// comment
    internal static let `continue` = L10n.tr("Localizable", "Button.Continue", fallback: "Continuer")
    /// comment
    internal static let ok = L10n.tr("Localizable", "Button.Ok", fallback: "Ok")
    /// comment
    internal static let retry = L10n.tr("Localizable", "Button.Retry", fallback: "Rééssayer")
  }
  internal enum RepoDetailViewController {
    /// comment
    internal static func description(_ p1: Any) -> String {
      return L10n.tr("Localizable", "RepoDetailViewController.Description", String(describing: p1), fallback: "Desription: %@")
    }
    /// comment
    internal static func fullName(_ p1: Any) -> String {
      return L10n.tr("Localizable", "RepoDetailViewController.FullName", String(describing: p1), fallback: "Nom: %@")
    }
  }
  internal enum RepoListViewController {
    /// comment
    internal static let title = L10n.tr("Localizable", "RepoListViewController.Title", fallback: "Liste des repositories")
    internal enum PlaceholderTableViewCell {
      /// comment
      internal static let label = L10n.tr("Localizable", "RepoListViewController.PlaceholderTableViewCell.Label", fallback: "Pas de Repos trouvés")
    }
    internal enum RepoTableViewCell {
      /// comment
      internal static func forks(_ p1: Any) -> String {
        return L10n.tr("Localizable", "RepoListViewController.RepoTableViewCell.Forks", String(describing: p1), fallback: "Forks: %@")
      }
      /// comment
      internal static func fullName(_ p1: Any) -> String {
        return L10n.tr("Localizable", "RepoListViewController.RepoTableViewCell.FullName", String(describing: p1), fallback: "Nom: %@")
      }
      /// comment
      internal static func openIssues(_ p1: Any) -> String {
        return L10n.tr("Localizable", "RepoListViewController.RepoTableViewCell.OpenIssues", String(describing: p1), fallback: "Questions ouvertes: %@")
      }
      /// comment
      internal static func watchers(_ p1: Any) -> String {
        return L10n.tr("Localizable", "RepoListViewController.RepoTableViewCell.Watchers", String(describing: p1), fallback: "Observateurs: %@")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
