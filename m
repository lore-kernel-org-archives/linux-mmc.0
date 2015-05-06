From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Wed, 6 May 2015 11:49:14 +0200
Message-ID: <CAPDyKFo9qDG5xvw3uB3qmL1C5-j9M80k7o7ggvAqPHEFe=pXVg@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
	<1430817426-5241-2-git-send-email-stripathi@apm.com>
	<CAPDyKFpfiid4ny0fhw-yNfzCrynZnALNs+i51yeMhPneQ4XFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34324 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbEFJtP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 05:49:15 -0400
Received: by qkgx75 with SMTP id x75so2126941qkg.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2015 02:49:14 -0700 (PDT)
In-Reply-To: <CAPDyKFpfiid4ny0fhw-yNfzCrynZnALNs+i51yeMhPneQ4XFFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On 5 May 2015 at 12:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 5 May 2015 at 11:17, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the arasan sdhc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> I consider this one acked by Arnd, due to:
> http://www.spinics.net/lists/arm-kernel/msg415634.html
>
> Thus applied to my mmc tree.

According to follow up comments, I have dropped this patch from my tree for now.

Kind regards
Uffe
