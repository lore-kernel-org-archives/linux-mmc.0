From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 00/26] pstore, mmc: add mmc as backend for pstore
Date: Mon, 29 Oct 2012 22:28:20 +0200
Message-ID: <20121029202820.GA21660@shutemov.name>
References: <1351000104-13015-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shutemov.name ([176.9.204.213]:60025 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab2J2U04 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 16:26:56 -0400
Content-Disposition: inline
In-Reply-To: <1351000104-13015-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-mmc@vger.kernel.org

On Tue, Oct 23, 2012 at 04:47:58PM +0300, Irina Tirdea wrote:
> These patches enable using the mmc card to store panic information.
> 
> They include changes for pstore and mmc:
>  - add block device backend for pstore
>  - add logic in mmc for writing in panic mode

Chris, any feedback on mmc/sdhci part?

-- 
 Kirill A. Shutemov
