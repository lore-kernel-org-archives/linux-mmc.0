From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
 selecting hs400es
Date: Thu, 22 Sep 2016 12:21:17 +0200
Message-ID: <CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
 <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoHxSpFurgV9swN3MCTWUinPFNUHSzxgyKj+K3iqkGSbA@mail.gmail.com> <62a8d622-39d2-db7d-042d-5425a3efba58@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62a8d622-39d2-db7d-042d-5425a3efba58@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 22 September 2016 at 12:06, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi ulf,
>
> =E5=9C=A8 2016/9/22 17:38, Ulf Hansson =E5=86=99=E9=81=93:
>>
>> On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
>>>
>>> Per JESD84-B51 P69, Host need to change frequency to <=3D52MHz after
>>> setting HS_TIMING to 0x1, and host may changes frequency to <=3D 200MHz
>>> after setting HS_TIMING to 0x3. It seems there is no difference if
>>> we don't change frequency to <=3D 52MHz as f_init is already less than
>>> 52MHz. But actually it does make difference. When doing compatibility
>>> test we see failures for some eMMC devices without changing the
>>> frequency to hs_max_dtr. And let's read the spec again, we could see
>>> that "Host may changes frequency to 200MHz" implies that it's not
>>> mandatory. But the "Host need to change frequency to <=3D 52MHz" implie=
s
>>> that we should do this.
>>
>>
>> I don't get this. Are you saying that f_init > 52 MHz? That should not
>> be impossible, right!?
>
>
> nope, I was saying that the spec implies we to set clock after
> setting HS_TIMING to 0x1 when doing hs400es selection.
>
> I thought there is no difference because the spec says "Host need to
> change frequency to <=3D 52MHz", and the f_init(<=3D400k) is <=3D 52MHz,
> right? So I didn't set clock to hs_max_dtr. But I think I misunderstood
> the spec, so this patch will fix this.

Okay, I see what you mean now!

In other words:
The card expects the clock rate to increase from the current used
f_init (which is <=3D 400KHz), but still being <=3D 52MHz, when you have
set HS_TIMING to 0x1.

Okay, we can do that change! Could you try to improve the change log a
little bit or you want me to help?

Kind regards
Uffe
