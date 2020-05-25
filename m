Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3FC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2449320890
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dE1V/r8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbgEYO1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 10:27:04 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:7220 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390879AbgEYO1E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590416824; x=1621952824;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=GFYGDQDidiAIsf6A9qkRWMwevlywavapMyZL4vq1R3o=;
  b=dE1V/r8PYysMBFIYfsnaQed5+M+qPNcngXFq9gTcl1tcWji3CEu1sCQr
   p8SbfqbFcXZ9Z1qz4zpE/CTdr0hwAscVZq9Nkd6ie/i11pt5qBwpyGKy6
   maUE7KtVGqte92kc4u3kbHJMjYLlxpUCCjpCsBRLkxwv6+HTPhZr8QKFR
   l/og+IggISkpNNpNP8WQQFV3piW1bDKP3mA3TekMoxOIGFyb3cuGVu2F8
   M6vqZ2NClBTLgnmzAT3+eb4OK6bIb9BtQqr0rs9HqQMGNx5lZp092OAoZ
   fipKqvRhsGfKKYU+c1jpX+ZrM4+TQrdQRhtFK3RJEFgRGzWf5C6xhtk6R
   w==;
IronPort-SDR: b2/4aXB09gGz4fU4ObByebBRtITl0q6dSxd9wzWdo7W8teK24GN3lCnoNM/H11S0qrmP3OYiyy
 b4+L8Z5qmZn8+jxryZ21rB3zJdnAHRZcsjA/tbRDvxAVwDtAKj/U5BlVt5Gxe5Bee1EdrygqN9
 JvnbXgC2QAM2vJwDviz4VRAl7bfYsUzXKqcmy9WvWo98gaHAjpFlMTVWLfs7oERoQcRaau9cFi
 /DxZBpY3JL7k02ALG+WCyBO7hh8rS4qULchSdVOmSZ4pkNXZzaEwTURAIDq1vljsMZnhjcBIBx
 aEY=
X-IronPort-AV: E=Sophos;i="5.73,433,1583218800"; 
   d="scan'208";a="74410943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2020 07:27:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 May 2020 07:27:02 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 May 2020 07:27:00 -0700
References: <20200513133122.25121-1-lars.povlsen@microchip.com> <20200513133122.25121-3-lars.povlsen@microchip.com> <6398c7a6-ce5e-1df6-d5a6-08664a7fc123@intel.com> <87v9ktoc0h.fsf@soft-dev15.microsemi.net> <87wo56q2o3.fsf@soft-dev15.microsemi.net> <abbd2306-55ed-014c-4b06-a5cb3f34796f@intel.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
List-Id: <soc.lore.kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        SoC Team <soc@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
In-Reply-To: <abbd2306-55ed-014c-4b06-a5cb3f34796f@intel.com>
Date:   Mon, 25 May 2020 16:26:59 +0200
Message-ID: <87sgfoozt8.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Adrian Hunter writes:

> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> On 20/05/20 2:14 pm, Lars Povlsen wrote:
>>
>> Lars Povlsen writes:
>>
>>> Adrian Hunter writes:
>>>
>>>> On 13/05/20 4:31 pm, Lars Povlsen wrote:
>>>>> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
>>>>> designware IP, but requires some extra initialization and quirks.
>>>>>
>>>>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>>>>> ---
>> {Snip]
>>>>> +};
>>>>> +
>>>>> +static const struct sdhci_pltfm_data sdhci_sparx5_pdata = {
>>>>> +     .quirks  = 0,
>>>>> +     .quirks2 = SDHCI_QUIRK2_HOST_NO_CMD23 | /* Card quirk */
>>>>
>>>> If this is a card quirk then it should be in drivers/mmc/core/quirks.h not here.
>>>
>>
>> Adrian, I had a go at changing the controller quirk to a card quirk.
>>
>> Unfortunately, SDHCI_QUIRK2_HOST_NO_CMD23 does not directly translate to
>> MMC_QUIRK_BLK_NO_CMD23, as for 'do_rel_wr' in mmc_blk_rw_rq_prep(), it
>> will *still* use MMC_SET_BLOCK_COUNT (cmd23), causing the issue.
>>
>> We are using a ISSI "IS004G" device, and so I have gone through the
>> motions of adding it to quirks.h. The comment before the list of devices
>> using MMC_QUIRK_BLK_NO_CMD23 suggest working around a performance issue,
>> which is not exactly the issue I'm seeing. I'm seeing combinations of
>> CMD_TOUT_ERR, DATA_CRC_ERR and DATA_END_BIT_ERR whenever a cmd23 is
>> issued.
>>
>> I have not been able to test the controller with another eMMC device
>> yet, but I expect its not the controller at fault.
>>
>> So, I'm a little bit in doubt of how to proceed - either keep the quirk
>> as a controller quirk - or make a *new* card quirk (with
>> SDHCI_QUIRK2_HOST_NO_CMD23 semantics)?
>>
>> Anybody else have had experience with ISSI eMMC devices?
>>
>> I have also tried to use DT sdhci-caps-mask, but MMC_CAP_CMD23 is not
>> read from the controller just (unconditionally) set in sdhci.c - so that
>> doesn't fly either.
>>
>> Any suggestions?
>
> It is up to you.  In the future, you may want to distinguish devices that
> have this problem from ones that do not.
>
> If you are not sure it is the ISSI eMMC, and maybe not the host controller,
> then might it be the board?  Perhaps make SDHCI_QUIRK2_HOST_NO_CMD23
> conditional on the particular compatibility string?
>
> At a minimum, change the "/* Card quirk */" comment to a fuller explanation.
>

Adrian, I'm getting a board ready with another eMMC device, and we're
also trying to contact ISSI for info.

My hope is to at least verify whether this is a controller or a card
issue one way or the other. Then, I'll choose an appropriate solution
for it.

Thank you for your advice so far.

---Lars

>>
>>> Yes, its supposedly a card quirk. I'll see to use the card quirks
>>> methods in place.
>>>
>>

-- 
Lars Povlsen,
Microchip
