From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of
 execute_tuning()
Date: Wed, 28 Jan 2015 16:55:28 -0800
Message-ID: <CAD=FV=VQg+sQUpgbKw7Zz=-f+jPM=6O-+3gUpohWhj8JeSPu6Q@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
 <1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
 <CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
 <CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Jianqun Xu <xjq@rock-chips.com>, chenfen <chenfen@rock-chips.com>, Chris Zhong <zyw@rock-chips.com>, lintao <lintao@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Han Jiang <hj@rock-chips.com>, Dinh Nguyen <dinguyen@altera.com>, Tao Huang <huangtao@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, =?UTF-8?B?5aea5pm65oOF?= <yzq@rock-chips.com>, zhangqing <zhangqing@rock-chips.com>K
List-Id: linux-mmc@vger.kernel.org

Ulf,

On Tue, Jan 27, 2015 at 7:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> I asked Addy to post upstream against mmc_send_tuning(), but I guess
>> he didn't (he posted against Alex's NAKed patch instead).
>>
>> ...when I talked to him about it, Addy was asserting that when tuning
>> fails it is important (at least on dw_mmc on rk3288) that we wait for
>> the card to stop being busy and that the way to detect was using
>> mmc_send_status().
>
> So, could that be due to the internal logic of the error handling in
> dw_mmc driver? Or you think this is a generic issue?
>
> According to the specifications (eMMC and SD) both states that the
> tuning command has an R1 response. So, there shouldn't be any busy
> signalling involved - at least according to spec.

I did a bit of digging into this issue myself.  What I found was that
a "response CRC" and "end of transfer".  This was why I posted up
<https://patchwork.kernel.org/patch/5623071/>.  From that patch:

> Specifically it looks like in certain error conditions (I saw this
> with Response CRC errors) that data keeps showing up in the FIFO even
> after the error is reported and the CD (command done) bit is set.  If
> we don't wait for this data to finish transferring then it confuses
> the next transaction.  In the specific failure case I ran into I found
> that I could monitor the data_state_mc_busy bit and wait for it to
> clear, but in other failure cases this bit was stuck at busy when we
> saw an error.  Hence a generic big delay seems like the only option.

...Addy instead fixed the problem using mmc_send_status() to try to
detect when the transfer was all done and it apparently worked, but it
seemed odd to me.  My MMC "expertise" pretty much ends with looking
for simple logic errors in the MMC driver, so my hope was that one of
you guys would know this better...


>> That would mean that against upstream you'd need to change
>> mmc_send_tuning() to take in the card as well (or move the "host->card
>> = card" assignment to before UHS init, which seems less desirable?)
>>
>> What do you think about that?  Is there a better solution?
>
> Why do we need to change mmc_send_tuning()? I thought the issue was
> that mmc_send_status(), which currently takes "card" as a parameter.

Well, if mmc_send_tuning() needed to call mmc_send_status() then
mmc_send_tuning() would need the card parameter, right?


Doug
