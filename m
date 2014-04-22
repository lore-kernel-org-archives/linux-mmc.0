From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 06/12] mmc: mmci: Add write delay to variant structure.
Date: Tue, 22 Apr 2014 09:15:31 +0100
Message-ID: <53562523.7020606@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org> <1398116898-31478-1-git-send-email-srinivas.kandagatla@linaro.org> <20140421220819.GA4468@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:44559 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbaDVIPe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Apr 2014 04:15:34 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4542893wes.6
        for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2014 01:15:33 -0700 (PDT)
In-Reply-To: <20140421220819.GA4468@saruman.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org

Thanks Felipe,

On 21/04/14 23:08, Felipe Balbi wrote:
>> +	if (var->reg_write_delay && host->mclk)
>> >+		udelay(1 + ((var->reg_write_delay * USEC_PER_SEC)/host->mclk));
> looks like this should be quirk flag instead of a write delay... No
> strong feelings though, but it looks like the following would be better,
> perhaps:
>
> 	if (host_is_qualcom(host))
> 		udelay(1 + ((3 * USEC_PER_SEC)/host->mclk));
Am ok with your proposal. I was wondering if someone else might need it 
in future.
If not I could change it as you suggested.

Thanks,
srini
>
> --
