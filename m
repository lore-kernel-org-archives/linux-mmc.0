From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Wed, 25 Oct 2017 18:47:08 +0200
Message-ID: <CAPDyKFo9jt6V01WWGEXuB7QFz6_-Gqiuzcujh3R-VO2A052DTA@mail.gmail.com>
References: <cover.1507315433.git.lsun@mellanox.com> <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
 <CGME20171017155217epcas3p4de2f27b921ce77234a2d3e46e4b17473@epcas3p4.samsung.com>
 <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <f71d94dc-7277-8675-c21e-9c2ec77174e7@samsung.com> <AM2PR05MB07537D50A18D391CD2295D84A1430@AM2PR05MB0753.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:52201 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdJYQrJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2017 12:47:09 -0400
Received: by mail-io0-f180.google.com with SMTP id b186so1686253iof.8
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2017 09:47:09 -0700 (PDT)
In-Reply-To: <AM2PR05MB07537D50A18D391CD2295D84A1430@AM2PR05MB0753.eurprd05.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>

Hi Liming,

Sorry for jumping into the discussion like this.

[...]

>> >> This series of commits enables the multi-card support for the dw-mmc
>> >> controller. It includes two parts as below.
>> >>
>> >> The first part (patches 1-7) reverts the series of recent commits
>> >> that removed the multi-card support with comments saying there was no
>> >> such use case in the real world. Actually this feature is being used
>> >> in Mellanox Bluefield SoC and has been requested by customers.
>> >
>> > Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8
>> and 9 said, you need them to fix problem for multi-card support, so definitely
>> there was no such use case, and even the code was buggy to support it right?
>> That makes the code hard to read and maintain, so we decide to remove it.

Unfortunate patch 8 and 9 does *not* solve the fundamental problem
with multiple slots. You can't solve it without involving the mmc
core, as explained in earlier discussions [1].

>>
>> Hmm..
>> Well, if i missed your reply for my removing patch, it's my fault..but i didn't
>> see any reply..
>> At that time, we didn't see any usage and also now...
>
> [Liming] It is definitely not anybody's fault. My apology that I should have made it very clear.
> This is a new SoC which uses two eMMC cards. This feature has been requested by customer.
> We made it working with patches, then realized that the support for the 2nd card was removed recently from upstream kernel.
> To avoid reinventing the wheel, a better approach appears to bring back the changes.
>
>>

Having multiple slots of eMMC:s, attached to one single mmc
controller, is really a terrible idea, even if one could get it to
somewhat work.

To deal with multiple slots from the mmc core point of view, we would
need to introduce  a kind of "bus slot lock", which needs to be taken
whenever the core access any of the registered two mmc hosts.

However, that then means that the upper block device layers can no
longer perform proper I/O scheduling of requests to the eMMC cards. In
other words, requests on one eMMC device can then starve requests
reaching the other eMMC device. It all falls apart.

Perhaps that is a limitation you think is okay to live with, but I am
really not so sure it's worth adding "multiple slot" support.

[...]

Kind regards
Uffe
