From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/7] mmc: dw_mmc: add device tree support
Date: Wed, 2 May 2012 11:07:45 -0700
Message-ID: <CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, May 1, 2012 at 10:07 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> Add device tree based discovery support.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> =A0.../devicetree/bindings/mmc/synposis-dw-mshc.txt =A0 | =A0 85 ++++=
+++++
> =A0drivers/mmc/host/dw_mmc-pltfm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 24 +++
> =A0drivers/mmc/host/dw_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0181 +++++++++++++++++++-
> =A0drivers/mmc/host/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 10 +
> =A0include/linux/mmc/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +
> =A05 files changed, 296 insertions(+), 6 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/mmc/synposis-=
dw-mshc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.t=
xt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> new file mode 100644
> index 0000000..c1ed70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> @@ -0,0 +1,85 @@
> +* Synopsis Designware Mobile Storage Host Controller
> +
> +The Synopsis designware mobile storage host controller is used to in=
terface
> +a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following
> + =A0 =A0 =A0 - synopsis,dw-mshc: for controllers compliant with syno=
psis dw-mshc.
> +
> +* reg: physical base address of the dw-mshc controller and size of i=
ts memory
> + =A0region.
> +
> +* interrupts: interrupt specifier for the controller. The format and=
 value of
> + =A0the interrupt specifier depends on the interrupt parent for the =
controller.
> +
> +# Slots: The slot specific information are contained within child-no=
des with
> + =A0each child-node representing a supported slot. There should be a=
tleast one
> + =A0child node representing a card slot. The name of the slot child =
node should
> + =A0be 'slot{n}' where n is the unique number of the slot connnected=
 to the
> + =A0controller. The following are optional properties which can be i=
ncluded in
> + =A0the slot child node.

Since we're talking slots / cards on a bus, I think the addressing
model would be useful here. So in the main controller node:
    #address-cells =3D <1>;
    #size-cells =3D <0>;

And then each slot would need a reg property and possibly unit address:

   slot {
        reg =3D <0>;
        ...
   };

(unit addresses on the slots are only needed if they can't be
disambiguated by name, so not needed if you only have one slot).


-Olof
