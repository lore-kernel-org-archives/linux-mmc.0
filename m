From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] Documentation: mmc: sdhci-of-arasan: add
 description of power domain
Date: Thu, 22 Sep 2016 09:14:03 +0200
Message-ID: <CAPDyKFo+DZkd4v06DOOHLBdAD-7UgYcBspbZkzFSnjA-a3pOkg@mail.gmail.com>
References: <20160917023250.1159-1-xzy.xu@rock-chips.com> <20160917023250.1159-2-xzy.xu@rock-chips.com>
 <CAPDyKFrgdsppLg9RkCsSh4nhjUiJR6D4u+E8qnzfbtNxhwLOmw@mail.gmail.com> <1ec66aea-10b4-4208-369e-9ef5feb800df@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35747 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756135AbcIVHOG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 03:14:06 -0400
Received: by mail-wm0-f50.google.com with SMTP id l132so309623016wmf.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2016 00:14:05 -0700 (PDT)
In-Reply-To: <1ec66aea-10b4-4208-369e-9ef5feb800df@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, zhangqing <zhangqing@rock-chips.com>

On 20 September 2016 at 04:29, Ziyuan Xu <xzy.xu@rock-chips.com> wrote:
> hi Ulf,
>
>
> On 2016=E5=B9=B409=E6=9C=8817=E6=97=A5 16:49, Ulf Hansson wrote:
>>
>> On 17 September 2016 at 04:32, Ziyuan Xu <xzy.xu@rock-chips.com> wrote:
>>>
>>> Add power domain as a optional property for sdhci-of-arasan, which can
>>> be turned off in the so-called unused condition, such as suspend and
>>> remove. Aim to lower power requirements.
>>
>> I assume runtime suspend make sense as well?
>
>
> Sorry to reply this mail after a long time.
>
> On rk3399 platform, there is a eMMC-phy which is in charge of eMMC's logi=
c
> interface. We should guarantee that phy is ready before cmd/data transfer=
.
> I mean that I need to consider about the resume latency, so that I can la=
nd
> RPM for arasan-of-sdhci.
> I intend to use auto-suspend for arasan-of-sdhci.
>

Okay!

>>
>> Moreover, perhaps you could share a little information here about what
>> needs to be done at the driver level which controls the mmc IP. More
>> precisely, what do you need to do at runtime_suspend, suspend,
>> runtime_resume, and resume?
>
>
> Invoke sdhci_runtime_suspend_host, disable relevant clock in
> rumtime_suspend, deprocessing in runtime_resume.
> Is that ok?

Okay!

[...]

Thanks for sharing some more information, could you please re-spin
with an updated change log?

Kind regards
Uffe
