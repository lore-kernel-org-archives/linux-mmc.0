From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 11/13] mmc: mmci: add explicit clk control
Date: Sun, 01 Jun 2014 19:13:28 +0100
Message-ID: <538B6D48.9060502@linaro.org>
References: <1401469918-26817-1-git-send-email-srinivas.kandagatla@linaro.org> <1401470080-27277-1-git-send-email-srinivas.kandagatla@linaro.org> <20140531122945.GA20736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:42363 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaFASNd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Jun 2014 14:13:33 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so4259539wes.1
        for <linux-mmc@vger.kernel.org>; Sun, 01 Jun 2014 11:13:31 -0700 (PDT)
In-Reply-To: <20140531122945.GA20736@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org

Thanks Russell,

On 31/05/14 13:29, Russell King - ARM Linux wrote:
>>
>> >+	if ((host->variant->explicit_mclk_control) &&
>> >+	    (ios->clock != host->clock_cache)) {
> Please explain what use these parens have (or just get rid of them as
> they're completely unnecessary - they do nothing for readability.)
I agree, will fix this in next version, It was a left over from my 
previous patches which had one more variable in that first check.

Thanks,
srini
