From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Wed, 12 Aug 2015 13:38:02 +0300
Message-ID: <55CB220A.5040209@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <28226759.dUa3lFkaxJ@wasted.cogentembedded.com>
 <20150812005901.GF15957@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34235 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbbHLKiH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 06:38:07 -0400
Received: by labd1 with SMTP id d1so6720146lab.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2015 03:38:04 -0700 (PDT)
In-Reply-To: <20150812005901.GF15957@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 8/12/2015 3:59 AM, Simon Horman wrote:

>> Renesas R8A7794 SoC also has the MMCIF controller...

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> This new compat string looks good to me.

> Acked-by: Simon Horman <horms+renesas@verge.net.au>

    Thank you. I've messed up the subject, so need to re-post.

>> ---
>> The patch is against Ulf Hansson's 'mmc.git'  repo's 'next' branch plus the
>> patch I posted earlier today...
>>
>> Changes in version 2:
>> - deferred R8A7793 support to the patch posted earlier by Ulrich Hecht;

> Perhaps it would be best to co-ordinate the R8A7793 and R8A7794
> changes to avoid tedious conflicts.

    I thought about taking out Ulrich's binding patch and re-posting it along 
with this one but finally decided not to ruin his series. Do you mean that I 
should have posted his patch along with mine?

MBR, Sergei

