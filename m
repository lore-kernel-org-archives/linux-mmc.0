From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv10 3/5] ARM: dts: exynos: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
Date: Mon, 18 Aug 2014 11:54:19 -0500
Message-ID: <53F22FBB.4010801@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com> <1407397082-32495-4-git-send-email-jh80.chung@samsung.com> <53F1F027.7060609@samsung.com> <53F20955.2050806@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53F20955.2050806@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 08/18/14 09:10, Andreas F=E4rber wrote:
> Hi Jaehoon,
>
> Am 18.08.2014 14:23, schrieb Jaehoon Chung:
>> Socfpga and Rockchip were queued into each SoC tree.
>> I want to know whether this patch is queued or not into Samsung-Soc =
tree.
>> Do you have any other plan for this patch?
>
> It isn't applied in his tree:
>
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/
>
> In fact Kukjin has not applied any patches for 3 weeks now, which lik=
ely
> means he's on vacation. I am hoping he will review this and the other
> pending conflicting patches to decide on a merge order and fix any
> trivial conflicts himself. ;)
>
Oh, I thought it has been queued in previous merge window with my ack.

OK, I've applied this in my tree for 3.18.

Thanks,
Kukjin
