Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EFEC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 05:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D359221EA
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 05:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAZFz6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:55:58 -0500
Received: from ns.iliad.fr ([212.27.33.1]:52266 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbhAYSkF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 13:40:05 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id BE74220CD1;
        Mon, 25 Jan 2021 19:39:08 +0100 (CET)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 9D2001FF42;
        Mon, 25 Jan 2021 19:39:06 +0100 (CET)
Subject: Re: [PATCH] mmc: brcmstb: Fix sdhci_pltfm_suspend link error
To:     Arnd Bergmann <arnd@kernel.org>, Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210125125050.102605-1-arnd@kernel.org>
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
Message-ID: <d5901e29-cbce-1c3e-15e6-15015c6e6be4@freebox.fr>
Date:   Mon, 25 Jan 2021 19:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125125050.102605-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jan 25 19:39:08 2021 +0100 (CET)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2021 13:50, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> sdhci_pltfm_suspend() is only available when CONFIG_PM_SLEEP
> support is built into the kernel, which caused a regression
> in a recent bugfix:
> 
> ld.lld: error: undefined symbol: sdhci_pltfm_suspend
>>>> referenced by sdhci-brcmstb.c
>>>>               mmc/host/sdhci-brcmstb.o:(sdhci_brcmstb_shutdown) in archive drivers/built-in.a
> 
> Making the call conditional on the symbol fixes the link
> error.
> 
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> It would be helpful if someone could test this to ensure that the
> driver works correctly even when CONFIG_PM_SLEEP is disabled

Good evening Arnd,

I have just given this patch a test, and the driver works fine on my side,
afterwards.

Tested-by: Nicolas Schichan <nschichan@freebox.fr>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f9780c65ebe9..dc9280b149db 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,7 +314,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -	sdhci_pltfm_suspend(&pdev->dev);
> +	if (IS_ENABLED(CONFIG_PM_SLEEP))
> +		sdhci_pltfm_suspend(&pdev->dev);
>  }
>  
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> 


-- 
Nicolas Schichan
Freebox SAS
