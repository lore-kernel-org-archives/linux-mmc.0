From: "T Krishnamoorthy, Balaji" <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/4] omap hsmmc device tree support
Date: Tue, 13 Mar 2012 21:13:30 +0530
Message-ID: <CANrkHUb3Aypm7H44-6efiEoka_WO20hW1vMy-wBV1RzkRPt_UQ@mail.gmail.com>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 12, 2012 at 8:32 PM, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> wrote:
> The series adds device tree support for OMAP hsmmc
> driver.
>
> Changes in V2:
> -1- Minor fixes based on comments from Grant.
> -2- Added a seperate compatible for omap3.
> -3- Added a new binding "ti,needs-special-reset"
> to handle some mmc modules which need special
> softreset sequence.
> -4- Updated board dts files with "status =3D disable;"
> for unused mmc modules.
>
> Rob,
> I retained your ack on patch 1 despite the additional
> binding that I added to handle the special softreset
> sequence. Let me know if you have any issues with it.
>
> Chris.
> Patch 1 and Patch 2 apply cleanly on mmc-next and can
> be taken in from the mmc tree after relevent acks from
> DT folks.
> Patch 3 and Patch 4 which update dts files, I plan to
> push via linux-omap/Tony's tree.
Hi Rajendra,

Tested this series on omap4sdp, so feel free to add
Tested-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

>
> The series is tested on omap4sdp (both external and emmc),
> omap4panda amd omap3beagle boards.
>
> Things to do:
> -1- Card detect isn't functional and needs twl4030 gpio
> to be DT converted.
> -2- pbias cell programming is missing and needs an OMAP
> control module driver.
>
> Rajendra Nayak (4):
> =A0mmc: omap_hsmmc: Convert hsmmc driver to use device tree
> =A0mmc: omap_hsmmc: Avoid a regulator voltage change with dt
> =A0arm/dts: OMAP4: Add mmc controller nodes and board data
> =A0arm/dts: OMAP3: Add mmc controller nodes and board data
>
> =A0.../devicetree/bindings/mmc/ti-omap-hsmmc.txt =A0 =A0 =A0| =A0 33 ++++=
+++
> =A0arch/arm/boot/dts/omap3-beagle.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 14 +++
> =A0arch/arm/boot/dts/omap3.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 16 ++++
> =A0arch/arm/boot/dts/omap4-panda.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 22 +++++
> =A0arch/arm/boot/dts/omap4-sdp.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 24 ++++++
> =A0arch/arm/boot/dts/omap4.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 31 +++++++
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 88 +++++++++++++++++++-
> =A07 files changed, 227 insertions(+), 1 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc=
.txt
