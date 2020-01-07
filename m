Return-Path: <SRS0=8m0a=24=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7749CC33C8C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DDA2072A
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgAGN7d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:59:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:14022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGN7d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 08:59:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 05:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="223185429"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2020 05:59:31 -0800
Subject: Re: [PATCH v1] mmc: sdhci: Increase sdhci_send_command timeout to
 100ms
To:     Peter Seiderer <ps.report@gmx.net>, linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20191227151442.9240-1-ps.report@gmx.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <605838f7-be0f-5a78-15ef-33a5f425b241@intel.com>
Date:   Tue, 7 Jan 2020 15:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227151442.9240-1-ps.report@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/12/19 5:14 pm, Peter Seiderer wrote:
> Fixes:
> 	$ mmc bootpart enable 1 1 /dev/mmcblk1
> [ 2339.324062] mmc1: Controller never released inhibit bit(s).
> [ 2339.329808] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 2339.336339] mmc1: sdhci: Sys addr:  0x11044000 | Version:  0x00000002
> [ 2339.342933] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [ 2339.349460] mmc1: sdhci: Argument:  0x03b34801 | Trn mode: 0x00000013
> [ 2339.356048] mmc1: sdhci: Present:   0x01fd8008 | Host ctl: 0x00000031
> [ 2339.362637] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [ 2339.369230] mmc1: sdhci: Wake-up:   0x00000008 | Clock:    0x0000001f
> [ 2339.375943] mmc1: sdhci: Timeout:   0x0000000f | Int stat: 0x00000000
> [ 2339.382542] mmc1: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
> [ 2339.389257] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000003
> [ 2339.395856] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000a000
> [ 2339.402577] mmc1: sdhci: Cmd:       0x0000061b | Max curr: 0x00ffffff
> [ 2339.409291] mmc1: sdhci: Resp[0]:   0x00000800 | Resp[1]:  0xffffffff
> [ 2339.415889] mmc1: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
> [ 2339.422602] mmc1: sdhci: Host ctl2: 0x00000008
> [ 2339.427203] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x3fc79208
> [ 2339.433913] mmc1: sdhci: ============================================
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 275102c0a1bf..011b3d322826 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1364,8 +1364,8 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	    cmd->opcode == MMC_STOP_TRANSMISSION)
>  		cmd->flags |= MMC_RSP_BUSY;
>  
> -	/* Wait max 10 ms */
> -	timeout = 10;
> +	/* Wait max 100 ms */
> +	timeout = 100;

The inhibits bits should not be set, so I am not sure if this is just
papering over the real issue.  Did mmc (utils) return an error?  Was the
eMMC useable after the error?  Any chance of getting a register dump without
the very long console delays?  What device and host controller was it?  What
kernel version?

>  
>  	mask = SDHCI_CMD_INHIBIT;
>  	if (sdhci_data_line_cmd(cmd))
> 

