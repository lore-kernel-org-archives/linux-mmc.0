From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 3/7] mmc: dw_mmc: add device tree support
Date: Thu, 10 May 2012 15:45:43 +0530
Message-ID: <CAJuYYwSmiPNrFhd9xr2AkAbRfJm_gP9ym+AXyy9jyPG3FnFuhA@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
	<CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Olof,

On 2 May 2012 23:37, Olof Johansson <olof@lixom.net> wrote:
> Hi,

[...]

>> +# Slots: The slot specific information are contained within child-n=
odes with
>> + =A0each child-node representing a supported slot. There should be =
atleast one
>> + =A0child node representing a card slot. The name of the slot child=
 node should
>> + =A0be 'slot{n}' where n is the unique number of the slot connnecte=
d to the
>> + =A0controller. The following are optional properties which can be =
included in
>> + =A0the slot child node.
>
> Since we're talking slots / cards on a bus, I think the addressing
> model would be useful here. So in the main controller node:
> =A0 =A0#address-cells =3D <1>;
> =A0 =A0#size-cells =3D <0>;
>
> And then each slot would need a reg property and possibly unit addres=
s:
>
> =A0 slot {
> =A0 =A0 =A0 =A0reg =3D <0>;
> =A0 =A0 =A0 =A0...
> =A0 };
>
> (unit addresses on the slots are only needed if they can't be
> disambiguated by name, so not needed if you only have one slot).
>

Is the addressing model as described above needed in this case? The
address for a slot is not used by the controller driver code and is
just a virtual number. It would be sufficient to represent the nodes
representing the slots with a unique name.

Thanks,
Thomas.
