From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdio add regulator vsdio
Date: Fri, 22 Jul 2011 15:25:08 +0800
Message-ID: <CAMj5BkjbWbvJwut-K0Fx-F7sx+ER-EoGdjf6B0vifhFCpT1mnA@mail.gmail.com>
References: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
	<1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
	<CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, frankh@marvell.com, Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Bing Zhao <bzhao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 22, 2011 at 2:50 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 21 July 2011 03:34, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
>> sdio client may be required power on/off dynamically.
>> With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down
>
> I think you can/should do this with vmmc. When the device gets powered
> down (e.g. in runtime suspend), the voltage should be cut, so it
> should be possible to use the existing regulator.

Have considered re-use vmmc before,
Consider dynamically power control only required for sdio, so use
vsdio to exclude potential issue to sd/mmc.
Anyway, will try re-use vmmc.

>
> I also looked at doing this before, when it looked like we would have
> to manipulate a GPIO reset line for SD8686. I decided that the current
> vmmc implementation in sdhci wasn't quite complete enough, but it
> wouldn't be much effort to correct this.
>
> Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
