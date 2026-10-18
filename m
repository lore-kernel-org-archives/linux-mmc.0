Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AF488224
	for <linux-mmc@vger.kernel.org>; Sun, 18 Oct 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324854; cv=none; b=S/wHq54W/5xht9jGXH3ewyJL4jvh9FhH3NsNkiyRAuE72XIBWk9bvat+mv6TH6daZt3hfT1XkZvA+QoXfpta2d1IUpxLkdK9DhZbmP5LpcSr3HBinSYZaeXFCZmEZ6L7+azg4AJ6GQch3W4ob5MUP2UlsBrOW/miP2GWkN1ikTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324854; c=relaxed/simple;
	bh=GUO6WJwPmgpOoeggYIX6ZDRnPZQ96+xELUXWOdRbu+Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=h0pGLBSZ7OBG68yRDL2LBOMEBnyJtYZY3Ru0Vy3A1qq/1nYkEwsifW+3C3KpwTgSkkUbXPtkCfke8DYM9Bb99OSsw1yudDRUx3TTOudTZ9dMZs2JkS+0sSVJnbn3KGJ3QHNGQrk5b510jPnAwHF2EtJyZzJhjAcQjg8/K1oydO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FSMv3AId; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FSMv3AId"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GUO6WJwPmgpOoeggYIX6ZDRnPZQ96+xELUXWOdRbu+Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792324845; v=1; x=1792929645;
 b=FSMv3AIdrdFXR9Cu1uwK2ZAX6vS7+Qn8xfx8U4vwZ3xtw4er1Pk61O8bI5NgIVE65CWfxJ9f
 lBEex2DXBPeY+5rplvuq3rmPmZPYNlMxpmP1tkTi1VWFhauHIC3iW8waWjEaB/GvgMkHL3R+eAF
 /Xev+XPNQEfnUVu75HXgCBcs=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 342359e879feaa67;
	Sun, 18 Oct 2026 12:00:45 +0000
X-Mizu-Trace-ID: 342359e879feaa67
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Oct 2026 12:00:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <8ac7b295da3af2836e88faeb2b464f6ca80932d1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent
 flag on sdio_func companion
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>, "Ulf Hansson"
 <ulfh@kernel.org>
Cc: "Hans de Goede" <johannes.goede@oss.qualcomm.com>, "Aaron Lu"
 <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
 linux-acpi@vger.kernel.org
In-Reply-To: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
References: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>

Hi Hans,

October 17, 2026 at 6:04 PM, "Hans de Goede" <johannes.goede@oss.qualcomm=
.com> wrote:

>=20
>=20Many MMC host drivers call pm_suspend_ignore_children() which allows
> to keep MMC cards and SDIO-functions on while the host is suspended.
>=20
>=20For SDIO functions which are in the ACPI power-domain this causes a r=
ace
> where the host may end up runtime-suspended before the driver for a SDI=
O
> function loads and probes it. When the probe() looses this race this ca=
uses
> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-do=
main
> code with e.g. the following error:
>=20
>=20 ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
>=20
>=20Busses using pm_suspend_ignore_children() for their children should s=
et
> acpi_device.power.flags.ignore_parent on the ACPI companion device of
> their children to avoid this.
>=20
>=20This is safe todo because drivers for sdio_func devices should always
> call sdio_claim_host() before doing any IO and that runtime-resumes
> the host.
>=20
>=20Add the missing setting of the acpi_device.power.flags.ignore_parent =
flag
> to fix probing of SDIO functions sometimes failing on ACPI systems with
> the error mentioned above.
>=20
>=20Also add a sdio_acpi_clear_handle() function to undo this, since the =
ACPI
> companion device wills stay around after removing the sdio_func device.=
 To
> make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handl=
e()
> also make it actually clear the companion pointer on the sdio_func devi=
ce.
> Technically this clearing is not really necessary since the sdio_func
> device will go away shortly afterwards anyways.
>=20
>=20Closes: https://github.com/MocLG/rtw/issues/2/
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
[...]
+
> +static void sdio_acpi_clear_handle(struct sdio_func *func)
> +{
> +     struct acpi_device *adev;
> +
> +     adev =3D ACPI_COMPANION(&func->dev);
> +     if (adev) {
> +             adev->power.flags.ignore_parent =3D false;
> +             ACPI_COMPANION_SET(&func->dev, NULL);
> +     }
>  }
>  #else
>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>  #endif
>
>  static void sdio_set_of_node(struct sdio_func *func)
[...]
> @@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> +     sdio_acpi_clear_handle(func);
> +
>       if (sdio_func_present(func))
>               device_del(&func->dev);
>

I am not an expert on this topic, but clearing the companion here
before device_del(), looks wrong to me. As far as I understand
device_add() binds this device with acpi_bind_one() and that takes
a reference on both the companion and the device. The unbinding is
done in device_del() via acpi_device_notify_remove(), which returns
early when the companion is NULL, so does acpi_unbind_one()
never run and the physical_node entry, the sysfs links and the
references from acpi_bind_one() all stay behind and does that also
mean that sdio_release_func() never runs, causing the sdio_func and
its card reference to leak on every removal?

Also it seems to me that the stale entry stays first in the physical
node list, so the next card init would fail
acpi_device_is_first_physical_node() and would gets no ACPI PM domain
at all. Therefore the flag set here would then do nothing.

Would it be enough to only clear ignore_parent in sdio_acpi_clear_handle(=
)
and let device_del() clear the companion?

Take this review with a grain of salt as I am not an expert on this
topic as I previously said.

Best regards,
Luka Gejak
