Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971EC33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51A2073A
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 09:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgAQJRs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:17:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:26298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgAQJRs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 04:17:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 01:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="scan'208";a="425897984"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2020 01:17:46 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: Disable 1.8V modes on external
 microSD on Lenovo Miix 320
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
 <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
 <4cdff7d3-47cf-1193-c413-036c3a2824bf@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <39d372ee-824b-5e57-99e7-45b0ea7b8847@intel.com>
Date:   Fri, 17 Jan 2020 11:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4cdff7d3-47cf-1193-c413-036c3a2824bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/01/20 3:26 pm, Hans de Goede wrote:
> HI,
> 
> On 16-01-2020 08:59, Adrian Hunter wrote:
>> On 15/01/20 5:31 pm, Hans de Goede wrote:
> 
> <snip>
> 
>>>>> Note that the suspend/resume handling is broken also in the sense that
>>>>> it does not disable the signal voltage during suspend.
>>>>
>>>> The bus power gets switched off if the card is runtime suspended.  The host
>>>> controller should go to D3cold which means everything off.
>>>
>>> Right, what I mean is that the _PS3 method is broken in that it does
>>> not turn off the voltage-regulator providing the signal voltage, as
>>> it does do on other machines with a non buggy implementation.
>>
>> Is that different to what you would get with Windows?
> 
> No Windows has the same problem.
> 
>> Also, you could possibly build a custom DSDT and fix the _PS0 and _PS3
>> yourself.  That requires building it into a custom kernel also though.
> 
> I have not tried, but yes that should work, but until we get some generic
> mechanism (*) in Linux / distro-s to provide DSDT overrides, that is not
> helpful for regular Linux users.
> 
> *) which also has copyright issues, so the chances of this ever happening
> are slim
> 
> <snip>
> 
>>>>>>> +static int quirks = -1;
>>>>>>> +module_param(quirks, int, 0444);
>>>>>>> +MODULE_PARM_DESC(quirks, "Override sdhci-acpi specific quirks");
>>>>>>
>>>>>> Why is a module parameter needed?
>>>>>
>>>>> The module parameter is purely to make testing if the same quirk(s)
>>>>> help on other devices easier. Like the debug_quirks[2] params in sdhci.c
>>>>
>>>> Mmm, but we already have SDHCI_QUIRK2_NO_1_8_V
>>>
>>> True, but this only applies to the sdcard slot and not to the eMMC,
>>> also you are asking for this to be changed to:
>>>
>>> SDHCI_ACPI_QUIRK_SD_SET_SIGNAL_3_3V_ON_SUSPEND
>>>
>>> Which is not duplicate. Anyways if you dislike the module parameter
>>> bits I can drop them and make this only available through the DMI quirks.
>>>
>>
>> It isn't dislike, it is whether it will ever be needed.
> 
> For this specific issue, chances are not that big we will need it
> on another device. The quirk added by the second patch, to disable
> (broken) read-only detection OTOH might very well be useful on some
> other devices.
> 
> And adding the option to override the quirks from the kernel commandline
> requires very little extra code.
> 
> Anyways, it is your call. Please let me know if you want to drop the
> module parameter for v2, or if you are ok with keeping it.

I would be more interested in something like below (completely untested).
Thoughts?


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 17 Jan 2020 11:01:31 +0200
Subject: [PATCH] mmc: sdhci: Add module param debug_spec

End users can have linux compatibility issues. SDHCI provides 2 module
params to help debug such issues: debug_quirks and debug_quirks2. Those
have 3 limitations:
 - they apply to all devices instead of a specific device
 - they overwrite all quirks instead of specific bits
 - they do not cover capabilities
Add a new module parameter debug_spec which addresses all 3 limitations.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6e22a800bded..096cec1afe8e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -46,6 +46,7 @@
 
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
+static char *debug_spec;
 
 static void sdhci_finish_data(struct sdhci_host *);
 
@@ -3860,6 +3861,34 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
+static void sdhci_update_debug_quirks_and_caps(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	unsigned int *vars[] = {&debug_quirks, &debug_quirks2, &host->caps,
+				&host->caps1, &mmc->caps, &mmc->caps2};
+	unsigned int mask, val, old, new;
+	const char *p = debug_spec;
+	int ret, var, n;
+	char id[32];
+
+	while (1) {
+		ret = sscanf(p, "%31s %d %x %x %n", id, &var, &mask, &val, &n);
+		if (ret != 4)
+			break;
+		p += n;
+		if (var >= ARRAY_SIZE(vars) ||
+		    strcmp(id, dev_name(mmc_dev(mmc))))
+			continue;
+		old = *vars[var];
+		new = (old & ~mask) | val;
+		if (old != new) {
+			*vars[var] = new;
+			DBG("debug_spec: updating var %d %#x -> %#x\n",
+			    var, old, new);
+		}
+	}
+}
+
 static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -3967,6 +3996,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	sdhci_read_caps(host);
 
+	sdhci_update_debug_quirks_and_caps(host);
+
 	override_timeout_clk = host->timeout_clk;
 
 	if (host->version > SDHCI_SPEC_420) {
@@ -4513,6 +4544,8 @@ int __sdhci_add_host(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;
 
+	sdhci_update_debug_quirks_and_caps(host);
+
 	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
 	if (!host->complete_wq)
 		return -ENOMEM;
@@ -4676,6 +4709,7 @@ module_exit(sdhci_drv_exit);
 
 module_param(debug_quirks, uint, 0444);
 module_param(debug_quirks2, uint, 0444);
+module_param(debug_spec, charp, 0444);
 
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");
@@ -4683,3 +4717,10 @@ MODULE_LICENSE("GPL");
 
 MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
 MODULE_PARM_DESC(debug_quirks2, "Force certain other quirks.");
+MODULE_PARM_DESC(debug_spec,
+		 "Alter quirks, sdhci capabilities and MMC capabilities. The "
+		 "string contains one or more: <device name> <variable> <mask> "
+		 "<value> where <variable> is 0 (debug_quirks), "
+		 "1 (debug_quirks2), 2 (sdhci->caps), 3 (sdhci->caps1), "
+		 "4 (mmc->caps) or 5 (mmc->caps2), <mask> is a hex bit mask of "
+		 "bits to change, and <value> is the hex value.");
-- 
2.17.1
