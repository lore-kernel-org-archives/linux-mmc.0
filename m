From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/10] mmc: Add support to Marvell Xenon SD Host Controller
Date: Wed, 23 Nov 2016 09:30:14 +0100
Message-ID: <87vavemwdl.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 31 Oct 2016 12:09:49 +0100")
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
Cc: Hilbert Zhang <zzhang@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Romain Perier <romain.perier@free-electrons.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehu da Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Xueping Liu <xpliu@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Yu Cao <yucao@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,
 
 On lun., oct. 31 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hello,
>
> This the second version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).
>
> Some of the remarks had been taking into account since the first
> version, according to Ziji Hu, here are the following chcanges:
> "Changes in V2:
>   rebase on v4.9-rc2.
>   Re-write Xenon bindings. Ajust Xenon DT property naming.
>   Add a new DT property to indicate eMMC card type, instead of using
>   variable card_candidate.
>   Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
>   Add support to HS400 retuning."
>
> I think the main open point which remains is about issuing commands
> from the ->set_ios() callback (in patch 7).
> Ulf, could you comment about it?

This part is the last thing missing, we are about to solve the last
issues about the binding, but we still didn't have your opinion about
issuing commands from the ->set_ios() callback and Adrian required it to
take this series.

To have more context you can have a look on:
http://marc.info/?l=linux-mmc&m=147618996414673&w=2

it is the original email where Adrian wanted your agreement.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
