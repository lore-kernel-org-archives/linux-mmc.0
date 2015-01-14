From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/2] mmc: dw_mmc: exynos: Add HS400 support
Date: Wed, 14 Jan 2015 16:56:46 +0100
Message-ID: <CAPDyKFo0YB6UpjQXxQ9d9VhE6quur0mo=YNLdzB=xQoCE4J9xQ@mail.gmail.com>
References: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
	<54B67001.2090002@samsung.com>
	<54B68CC6.1040907@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:38217 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbANP4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jan 2015 10:56:46 -0500
Received: by mail-qc0-f171.google.com with SMTP id b13so3787958qcw.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2015 07:56:46 -0800 (PST)
In-Reply-To: <54B68CC6.1040907@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Doug Anderson <dianders@chromium.org>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14 January 2015 at 16:35, Kukjin Kim <kgene@kernel.org> wrote:
> On 01/14/15 22:32, Jaehoon Chung wrote:
>> Hi, Alim.
>>
>> On 01/14/2015 07:30 PM, Alim Akhtar wrote:
>>> This adds HS400 mode support for exynos dw_mmc host controller.
>>>
>>> Currently tested on Exynos5800-peach-pi platform for HS400 mode.
>>> Tested HS200 mode with this series applied, HS200 still works.
>>>
>>> Appreciate testing on other exynos5/7 platform which supports emmc5.0
>>
>> I will test this patch on exynos5/7 board.
>>
>
> What's the result? :-) If it's OK, I'll take DT changes for exynos
> stuff, I'm not sure about the driver changes though...

Kukjin,

As I understand it, there is a dependency between the patches, since
driver adds supports for new DT bindings.

So, unless I am mistaken I think it would be best to take this
complete patchset through my mmc tree. With your ack of course.

Kind regards
Uffe
