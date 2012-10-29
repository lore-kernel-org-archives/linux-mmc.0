From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 00/26] pstore, mmc: add mmc as backend for pstore
Date: Mon, 29 Oct 2012 16:50:42 -0400
Message-ID: <87390xroil.fsf@octavius.laptop.org>
References: <1351000104-13015-1-git-send-email-irina.tirdea@intel.com>
	<20121029202820.GA21660@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121029202820.GA21660@shutemov.name> (Kirill A. Shutemov's
	message of "Mon, 29 Oct 2012 22:28:20 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 29 2012, Kirill A. Shutemov wrote:
> On Tue, Oct 23, 2012 at 04:47:58PM +0300, Irina Tirdea wrote:
>> These patches enable using the mmc card to store panic information.
>> 
>> They include changes for pstore and mmc:
>>  - add block device backend for pstore
>>  - add logic in mmc for writing in panic mode
>
> Chris, any feedback on mmc/sdhci part?

Looks like the patchset hasn't been sent to linux-mmc@vger.kernel.org
yet -- could you send a v2 with that address included, please?

It would also be great to see descriptive commit messages, rather than
just patch subject lines.

Documentation-wise, the patchset mentions that host controller support
is required for this to work, but doesn't explain what kind of support
that is, and the sdhci-pci support seems unconditional on type of host
controller -- why wouldn't every controller work?  Is it (just) because
other controller drivers use msleep?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
