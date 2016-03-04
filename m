From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCH v5 0/2] Add phy support for arasan,sdhci-5.1
Date: Fri, 4 Mar 2016 11:18:10 +0200
Message-ID: <56D952D2.9070800@intel.com>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFojtZamH-xwM9UTyWdeW3SSSS3-uUyVr2R1t9NkwCXvYg@mail.gmail.com>
 <56D8E48B.1040604@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D8E48B.1040604@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/03/16 03:27, Shawn Lin wrote:
> =E5=9C=A8 2016/2/20 6:23, Ulf Hansson =E5=86=99=E9=81=93:
>>
>> Den 19 feb 2016 3:24 fm skrev "Shawn Lin" <shawn.lin@rock-chips.com
>> <mailto:shawn.lin@rock-chips.com>>:
>>  >
>>  >
>>  > Hello Ulf and Adrian,
>>  >
>>  > Sorry for delay the new version for this topic. Actually I have n=
o
>>  > platform available to test phy stuff since v4. Now, I can rework =
it.:)
>>  > I remove rpm support from v5 because this patchset just need to f=
ocus
>>  > on phy stuff, which will make the changes more precise. Another r=
eason
>>  > is that phy_power_on take too much time from rpm, however the pow=
er
>> profit
>>  > gained from phy_power_off is little due to the low power mechanis=
m
>> with the
>>  > phy itself observed from experiments.
>>  >
>>  > v4 can be found here:
>>  > https://patchwork.kernel.org/patch/7463251/
>>  >
>>  > Note:
>>  > Phy is mandatory requirement for arasan,sdhci-5.1, so we introduc=
e
>>  > generic phy support for sdhci-of-arasan.
>>  >
>>  >
>>  > Shawn Lin (2):
>>  >   Documentation: bindings: add description of phy for sdhci-of-ar=
asan
>>  >   mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
>>  >
>>  >  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 ++++++-
>>  >  drivers/mmc/host/sdhci-of-arasan.c                 | 66
>> ++++++++++++++++++++--
>>  >  2 files changed, 80 insertions(+), 6 deletions(-)
>>  >
>>  > --
>>  > 2.3.7
>>  >
>>  >
>>
>> This looks good to me! When acks has been received I am ready to que=
ue
>> it for next.
>>
>=20
> Hi Adrian,
>=20
>     Any chance to look at this patch? I assume Ulf need your ack for
> sdhci* patch. :)

Just sent some comments.
