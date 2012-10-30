From: Philip Rakity <prakity@nvidia.com>
Subject: Re: sdhci vccq regulator support drops UHS-I flags
Date: Tue, 30 Oct 2012 21:37:00 +0100
Message-ID: <E4ECCB94-95A7-4350-8FBD-1CB0D6D52ED6@nvidia.com>
References: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:2490 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934510Ab2J3UhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 16:37:03 -0400
In-Reply-To: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Daniel,

Intentional.  

if no vqmmc regulator then just assume it will work.

if there is a regulator it needs to support 1.8V.  (If I remember correctly UHS mode require 1.8V vccq)  I need to check if we 1.2V should be allowed but it was not in the spec that I had.

Are you thinking we need 1.2V support ?  

regards,

Philip


On Oct 30, 2012, at 9:30 PM, Daniel Drake <dsd@laptop.org> wrote:

> Hi,
> 
> Please check this commit:
> 
> 
> commit 6231f3de1332b2a8a90e0c598ab6acc8f1eff7c1
> Author: Philip Rakity <prakity@marvell.com>
> Date:   Mon Jul 23 15:56:23 2012 -0700
> 
>    mmc: sdhci: Add regulator support for vccq (voltage regualor)
> 
> Particularly this hunk:
> 
> +       /* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> +       host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> +       if (IS_ERR(host->vqmmc)) {
> +               pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> +               host->vqmmc = NULL;
> +       }
> +       else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
> +               regulator_enable(host->vqmmc);
> +       else
> +               caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +                      SDHCI_SUPPORT_DDR50);
> 
> One effect of this code is that if the system has no vqmmc regulator,
> the UHS-I flags are always cleared on the final line, so the ultra
> speed mode is always disabled.
> 
> Is this intentional or is there a check missing?
> 
> Thanks
> Daniel

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
