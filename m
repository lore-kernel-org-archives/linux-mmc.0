Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D91C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4219A22472
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 12:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbhAYMPV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 07:15:21 -0500
Received: from ns.iliad.fr ([212.27.33.1]:43210 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbhAYMO1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 07:14:27 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 696D2201B0;
        Mon, 25 Jan 2021 12:42:55 +0100 (CET)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 53799201AB;
        Mon, 25 Jan 2021 12:42:55 +0100 (CET)
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20210107221509.6597-1-alcooperx@gmail.com>
From:   Nicolas Schichan <nschichan@freebox.fr>
Autocrypt: addr=nschichan@freebox.fr; prefer-encrypt=mutual; keydata=
 xsDiBEmTLz8RBADBY46VzpMBGf4or14ijXlvY0jzJsBfWiBtpAbEGmyAEwf9olyd5yMrEnE1
 qJk0NpcOMiXB/DMvOhJv4kxY6KT6r1y1UwmolkMJ782kt2zqyxaLpXsdSFBnLaN38XKgsvtW
 snnFCA6FT3bYNPNVgNMuog2UhUn2eKGVBVW0nuFbGwCg5WM290H0BLJE9+v+z6UBqC0MIhED
 /jENkiSXAhRzbFLc7cusXxmAUQlGO7kmWkZAShC+p2W/a/1BhCoefunkLKlMlJpSJJklbseQ
 RZxfyImKFuep1pRhHM6PDpXP49jfYF6WYbbq7Bx752uUkRD9D5XqHfgPRuFRUC79rDgxFZv9
 2Umxuyacsg6gU0O3B8z2r0koXhffBACBymptu/4uHXO98HUuc92PwwswzqPyYXdZUQs37Fgc
 rMZxR4utRzWDnLy81bRn00yHVfK/FJ14Bxx06xlLnmFZC3fy3z+g2cRxKFZ5H9AI0OnNQD69
 eJTbARTNbKsgUvjqTvZTMg6TlesKSRI4kgCl9eejyrMuvOkSmeAnXwQHJM0nTmljb2xhcyBT
 Y2hpY2hhbiA8bnNjaGljaGFuQGZyZWVib3guZnI+wmAEExECACAFAkmTLz8CGwMGCwkIBwMC
 BBUCCAMEFgIDAQIeAQIXgAAKCRCL3CkFLvhg0PwDAKDQJXWNg9QyfYatePfw4W2k1oKOSwCg
 ldD3GhvlDaYUjIcgpTGsK+21OnXOwU0ESZMvSRAIAIau5WL6+zCIjb9WTTf6bX1ULD3gtWTB
 i/APtidAfIZJe87T7S7x3v7RRAPo5CAb787jgHZPzbZ2kRBbAPWB9ZF0d11m9Le3kmJPr6Lj
 tSPGX8FY+T1pvUIi2OIbhVgKC5QpLB0pq8ISAEk1N/9eBGo7QXOEyeHwhIQS6+kOj5HlyA5U
 sIw3M0bNTz9MWudHGphoad5ZF+gGVAXCN5s6TTSsKxWrejacaz0Y5r1nFjelK1fnqEWpiMD6
 sh4Bv1gawiMOowd1tgeHeyvabRiBF780yU5EeNpv5T1vTUCaphPfFbPdrnOjrleN+kNqN8kS
 4b3G+WvEz+t9NRvFUiQgB+MAAwUH/3bx27p+GDxAwduC9rwvD2WbPkRYaMjTTcm7y+ssqCdL
 VosZGFuqWdjcoc7sYsY6cfciupLAmSaX0kIPtzS0VBmzgtQRpdJSiC2ZskdMBg9/5C5lYWx9
 T5Y8ys82LT8AmX3CzQbc1duk4bZ5bg5DrS79I2lE/2bzCS/HbIWNwCuunwk9s9A7KU8KhpXh
 Xo7LUwYRJVsYjrhOGJcgPtPMp4ReFHtHlp5AaXEmZbBq1gtYwotd3eNXgp+gClXNxzI/+vW5
 d/u1t7Og6qXSJlYGK8Xbc/zZyU3BfR9u17jlJlPp51lXNF3MkMHcdWa31fnmsmqRCcq8FF8j
 RDBuScP0gj7CSQQYEQIACQUCSZMvSQIbDAAKCRCL3CkFLvhg0OK6AJ4+05fuwuFFrGNahTwK
 3SjvbE3HRwCgyuYgGcOqrIycpseHVTZlVuxF0Q8=
Message-ID: <6ce58f44-050d-3716-791c-0e924b43d26a@freebox.fr>
Date:   Mon, 25 Jan 2021 12:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107221509.6597-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jan 25 12:42:55 2021 +0100 (CET)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/01/2021 23:15, Al Cooper wrote:
> Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> that added a shutdown callback to the diver, is causing "mmc timeout"
> errors on S5 suspend. The problem was that the "remove" was queuing
> additional MMC commands after the "shutdown" and these caused
> timeouts as the MMC queues were cleaned up for "remove". The
> shutdown callback will be changed to calling sdhci-pltfm_suspend
> which should get better power savings because the clocks will be
> shutdown.
> 
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index bbf3496f4495..f9780c65ebe9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -	int ret;
> -
> -	ret = sdhci_pltfm_unregister(pdev);
> -	if (ret)
> -		dev_err(&pdev->dev, "failed to shutdown\n");
> +	sdhci_pltfm_suspend(&pdev->dev);
>  }
>  
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> 

Good morning,

Unfortunately this patch will cause link failures when CONFIG_PM_SLEEP is not
set in the kernel config, as in sdhci-pltfm.c, the implementation of
sdhci_pltfm_suspend() is in between #ifdef CONFIG_PM_SLEEP:

/opt/toolchains/aarch64-musl-1.1.21-gcc-8.3.0-binutils-2.32-gdb-7.12.1-2/bin/aarch64-linux-musl-ld:
drivers/mmc/host/sdhci-brcmstb.o: in function `sdhci_brcmstb_shutdown':
sdhci-brcmstb.c:(.text+0x16c): undefined reference to `sdhci_pltfm_suspend'
sdhci-brcmstb.c:(.text+0x16c): relocation truncated to fit: R_AARCH64_CALL26
against undefined symbol `sdhci_pltfm_suspend'


I'm not sure if definiting sdhci_pltfm_suspend() empty stubs in sdhci-pltfm.h
when CONFIG_PM_SLEEP is not set would be prefered over adding #ifdef
CONFIG_PM_SLEEP in sdhci-brcmstb.c, but I can send a patch for either solution.

Regards,

-- 
Nicolas Schichan

