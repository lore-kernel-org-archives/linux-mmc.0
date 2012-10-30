From: Philip Rakity <prakity@nvidia.com>
Subject: Re: sdhci vccq regulator support drops UHS-I flags
Date: Tue, 30 Oct 2012 22:07:02 +0100
Message-ID: <548D1E66-2AAF-4ACC-B08D-4F5B2719605F@nvidia.com>
References: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
 <E4ECCB94-95A7-4350-8FBD-1CB0D6D52ED6@nvidia.com>
 <CAMLZHHTDrzMc8J89dbyuvy6P_Qe0ynoQW7RFje9_8ppYNkFOSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:19122 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934562Ab2J3VHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 17:07:04 -0400
In-Reply-To: <CAMLZHHTDrzMc8J89dbyuvy6P_Qe0ynoQW7RFje9_8ppYNkFOSw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The intent is if there is no regulator should hit this if statement.

+       if (IS_ERR(host->vqmmc)) {
+               pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
+               host->vqmmc = NULL;


On Oct 30, 2012, at 9:56 PM, Daniel Drake <dsd@laptop.org> wrote:

> On Tue, Oct 30, 2012 at 2:37 PM, Philip Rakity <prakity@nvidia.com> wrote:
>> Intentional.
>> 
>> if no vqmmc regulator then just assume it will work.
> 
> When you say "it", do you mean "UHS-I support"?
> The code in this case will *disable* UHS-I support, because these lines are hit.
> +               caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +                      SDHCI_SUPPORT_DDR50);
> 
>> if there is a regulator it needs to support 1.8V.  (If I remember correctly UHS mode require 1.8V vccq)  I need to check if we 1.2V should be allowed but it was not in the spec that I had.
> 
> I'm asking about the case when there is no regulator.
> 
> Thanks
> Daniel

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
