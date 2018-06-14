From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 6/7] mmc: sunxi: Add runtime_pm support
Date: Thu, 14 Jun 2018 11:57:03 -0700
Message-ID: <CAOi56cV_6GLDZsRxSb8JWaJcrB-7evto82+uJTZRUoF=6z7zVA@mail.gmail.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <4514368de4ef7b4224be455f2d9e6090b464e819.1523888566.git-series.maxime.ripard@bootlin.com>
 <1caa07d2-17ad-18aa-9216-037c06b36281@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1caa07d2-17ad-18aa-9216-037c06b36281@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Quentin Schulz <quentin.schulz@bootlin.com>, maxime.ripard@bootlin.com, linux-mmc <linux-mmc@vger.kernel.org>, =?UTF-8?B?Q2hlbi1ZdSBUc2FpICjolKHpjq7lrocp?= <wens@csie.org>, thomas.petazzoni@bootlin.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 14, 2018 at 7:12 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Maxime,
>
> On 16/04/18 15:23, Maxime Ripard wrote:
> > So far, even if our card was not in use, we didn't shut down our MMC
> > controller, which meant that it was still active and clocking the bus.
> >
> > While this obviously means that we could save some power there, it also
> > creates issues when it comes to EMC control since we'll have a perfect peak
> > at the card clock rate.
> >
> > Let's implement runtime_pm with autosuspend so that we will shut down the
> > controller when it's not been in use for quite some time.
> >
[...]

> This patch has the unfortunate impact of killing my A20 system
> (cubietruck), as of 9a8e1e8cc2c02c57c4e941651a8481a633506c91:

kernelCI also found failures on a few a10/a20 platfforms[1], and they
all fail to reach userspace, similar to what Marc reported.

I bisected on a sun7i-a20-bananapi and that pointed at this commit
also (in mainline as 9a8e1e8cc2c0 mmc: sunxi: Add runtime_pm support)

Kevin

[1] https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.17-11928-g2837461dbe6f/
[2] $ git bisect log
git bisect start
# good: [5037be168f0e4ee910602935b1180291082d3aac] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good 5037be168f0e4ee910602935b1180291082d3aac
# bad: [f60342fac9fae20ada2cd5faadbc2a1337cae03f] Merge tag
'mmc-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad f60342fac9fae20ada2cd5faadbc2a1337cae03f
# good: [fd59ccc53062964007beda8787ffd9cd93968d63] Merge tag
'fscrypt_for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt
git bisect good fd59ccc53062964007beda8787ffd9cd93968d63
# good: [2158091d9cda6f126f71973667e8a9fc1e795d03] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good 2158091d9cda6f126f71973667e8a9fc1e795d03
# bad: [bfd694d5e21c2f0d344db6afeaf993bb0f299545] mmc: core: Add
tunable delay before detecting card after card is inserted
git bisect bad bfd694d5e21c2f0d344db6afeaf993bb0f299545
# good: [743b819e4178935e3f098e5f13db301f532fa9e0] mmc: sunxi: Reorder
the headers
git bisect good 743b819e4178935e3f098e5f13db301f532fa9e0
# bad: [ebca50dfae525341c48c2f69798667352318549e] mmc:
renesas_sdhi_internal_dmac: remove superfluous WARN
git bisect bad ebca50dfae525341c48c2f69798667352318549e
# bad: [eef797ac13c08fae0f0ce7d2215d0951e884fa2d] mmc: sunxi: Drop the
init / reset of the controller from set_ios
git bisect bad eef797ac13c08fae0f0ce7d2215d0951e884fa2d
# good: [ad04d9555da02c719de25b7d1e81ea8d0d2c4838] mmc: sunxi: Move
clock configuration to a function
git bisect good ad04d9555da02c719de25b7d1e81ea8d0d2c4838
# bad: [9a8e1e8cc2c02c57c4e941651a8481a633506c91] mmc: sunxi: Add
runtime_pm support
git bisect bad 9a8e1e8cc2c02c57c4e941651a8481a633506c91
# good: [e27e1f3d04061ccc3735361554088cd7aa286e31] mmc: sunxi: Move
the card power configuration to a function
git bisect good e27e1f3d04061ccc3735361554088cd7aa286e31
# first bad commit: [9a8e1e8cc2c02c57c4e941651a8481a633506c91] mmc:
sunxi: Add runtime_pm support
