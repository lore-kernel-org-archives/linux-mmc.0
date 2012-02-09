From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/4] mmc: core: add high-capacity erase size capability
 flag
Date: Thu, 09 Feb 2012 09:02:39 +0200
Message-ID: <4F336F8F.9080809@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com> <1328618935-25175-2-git-send-email-adrian.hunter@intel.com> <CACRpkdZPQwO19y-JxY86QQtUri-1uxUHX5V1gkgfGDtNZSXaBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2BIHCf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Feb 2012 02:02:35 -0500
In-Reply-To: <CACRpkdZPQwO19y-JxY86QQtUri-1uxUHX5V1gkgfGDtNZSXaBQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 09/02/12 00:38, Linus Walleij wrote:
> On Tue, Feb 7, 2012 at 1:48 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Let drivers specify the use of high-capacity erase size.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> (...)
>> @@ -949,7 +949,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>         * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
>>         * bit.  This bit will be lost every time after a reset or power off.
>>         */
>> -       if (card->ext_csd.enhanced_area_en) {
>> +       if (card->ext_csd.enhanced_area_en ||
>> +           (card->ext_csd.rev >= 3 && (host->caps2 & MMC_CAP2_HC_ERASE_SZ))) {
> 
> It looks like there is a bug fix hidden inside this patch, is it not?
> The comparison for card->ext_csd.rev >= 3 was not there before,
> and looks like it's fixing something and should go into stable even,
> is that correct?

No because because enhanced areas were added in v4.4 so
"card->ext_csd.enhanced_area_en" implies "card->ext_csd.rev >= 4"

High-capacity erase size was added in v4.3 so "card->ext_csd.rev >= 3"
is parenthesised with "(host->caps2 & MMC_CAP2_HC_ERASE_SZ)"
