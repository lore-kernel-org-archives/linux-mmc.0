From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Wed, 7 May 2014 13:49:06 -0700
Message-ID: <CAAYSxhr15dMLT8kuBd6gaFX+WrRgAqxKoWPBgkfVhzHMx299=A@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <535E84FB.4080305@wwwdotorg.org> <86mwf5tn0v.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <86mwf5tn0v.fsf@void.printf.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <chris@printf.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Doc List <linux-doc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, Jaehoon Chung <jh80.chung@samsung.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Device Tree List <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, spear-devel@list.st.com, Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Shawn Guo <shawn.guo@freescale.com>, Barry Song <baohua@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Viresh
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 28, 2014 at 9:52 AM, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Mon, Apr 28 2014, Stephen Warren wrote:
>> The series,
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>
>> (On an NVIDIA Tegra "Jetson TK1" board, with the patches applied on top
>> of next-20140428, also with Andrew Bresticker's Tegra SDHCI patches
>> "mmc: tegra: disable UHS modes" and "mmc: tegra: fix reporting of base
>> clock frequency" applied)
>
> Thanks very much Stephen, Russell for the series, and Ulf.
>
> This seems like a good time to merge to mmc-next and call for testing
> in linux-next -- I'm happy to merge a v2 PR when ready.
>
> - Chris.

Hi Russell,

Do you have a rough idea about when you will post your v2 pull request?

I have a pending sdhci patch that I would like to rebase on top of
your latest work once it is available.

Thanks,
Tim Kryger
