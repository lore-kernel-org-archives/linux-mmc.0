From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
Date: Thu, 16 Feb 2012 22:04:45 +0900
Message-ID: <4F3CFEED.6060206@samsung.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>	<003401cce730$baf979a0$30ec6ce0$%kim@samsung.com> <m2aa4pkq5g.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62428 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2BPNEv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2012 08:04:51 -0500
In-Reply-To: <m2aa4pkq5g.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org

On 02/12/12 06:37, Chris Ball wrote:
> Hi,
>
> On Thu, Feb 09 2012, Kukjin Kim wrote:
>> Looks ok to me and I'd like to pick this series in samsung tree with Chris'
>> ack.
>>
>> Chris, is it ok? If you need to merge this in your tree, please let me know.
>> I will provide topic branch for it.
>>
>> If any problems, please let me know.
>
> I don't have a very strong opinion, but I think it's probably better to
> go via the mmc tree since the patch is so large and hence the chance of
> conflict before merging is high.  Thanks,
>
Hi Chris,

I mean if I or you create topic branch for this whole series, can be 
merged into both tree for avoiding conflicts with further working. Of 
course, the topic branch don't have to rebase after merging into each tree.

If you're ok on this and my opinion, let me create the topic branch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
