From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH 0/4] mmc: sunxi: Make sample clocks optional
Date: Tue, 19 Jul 2016 16:59:58 +0800
Message-ID: <262161468918798@web25j.yandex.ru>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



16.07.2016, 18:50, "Hans de Goede" <hdegoede@redhat.com>:
> Hi All,
>
> It turns out that sun4i / sun5i do not have sample clocks at all,
> so make them optional. Also remove the DDR capability when there
> are no sample clocks because DDR modes do not work reliably without
> them (observed on an UTOO P66 tablet with eMMC).
>
> Ulf, can you please merge the first 2 patches, patches 3-4 should
> be merged through Maxime's sunxi/dts tree, but not before the first
> 2 have hit linux-next.
>
> Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Interesting...

A64 have also no external sample/output clock... (The sample/output clock is integrated into MMC IP core now)
