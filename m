From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 3/3] mmc: sdhci-msm: Add platform_execute_tunning
 implementation
Date: Fri, 28 Feb 2014 14:51:19 -0600
Message-ID: <20140228205119.GJ7308@joshc.qualcomm.com>
References: <1393586675-14628-1-git-send-email-gdjakov@mm-sol.com>
 <1393586675-14628-4-git-send-email-gdjakov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393586675-14628-4-git-send-email-gdjakov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Georgi Djakov <gdjakov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 28, 2014 at 01:24:35PM +0200, Georgi Djakov wrote:
> This patch adds implementation for platform specific tuning in order =
to support
> HS200 bus speed mode on Qualcomm SDHCI controller.
>=20
> Signed-off-by: Asutosh Das <asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Georgi Djakov <gdjakov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-msm.c |  424 ++++++++++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 418 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-ms=
m.c
> index b4490a2..69f6887 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
[..]
> +int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int tuning_seq_cnt =3D 3;
> +	u8 phase, *data_buf, tuned_phases[16], tuned_phase_cnt =3D 0;
> +	const u32 *tuning_block_pattern =3D tuning_block_64;
> +	int size =3D sizeof(tuning_block_64);	/* Pattern size in bytes */
> +	int rc;
> +	struct mmc_host *mmc =3D host->mmc;
> +	struct mmc_ios ios =3D host->mmc->ios;
> +
> +	/*
> +	 * Tuning is required for SDR104, HS200 and HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock <=3D 100 * 1000 * 1000 ||
> +	    !((ios.timing =3D=3D MMC_TIMING_MMC_HS200) ||
> +	      (ios.timing =3D=3D MMC_TIMING_UHS_SDR104)))
> +		return 0;
> +
> +	if ((opcode =3D=3D MMC_SEND_TUNING_BLOCK_HS200) &&
> +	    (mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_8)) {
> +		tuning_block_pattern =3D tuning_block_128;
> +		size =3D sizeof(tuning_block_128);
> +	}
> +
> +	data_buf =3D kmalloc(size, GFP_KERNEL);
> +	if (!data_buf)
> +		return -ENOMEM;
> +
> +retry:
> +	/* First of all reset the tuning block */
> +	rc =3D msm_init_cm_dll(host);
> +	if (rc)
> +		goto out;
> +
> +	phase =3D 0;
> +	do {
> +		struct mmc_command cmd =3D { 0 };
> +		struct mmc_data data =3D { 0 };
> +		struct mmc_request mrq =3D {
> +			.cmd =3D &cmd,
> +			.data =3D &data
> +		};
> +		struct scatterlist sg;
> +
> +		/* Set the phase in delay line hw block */
> +		rc =3D msm_config_cm_dll_phase(host, phase);
> +		if (rc)
> +			goto out;
> +
> +		cmd.opcode =3D opcode;
> +		cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +		data.blksz =3D size;
> +		data.blocks =3D 1;
> +		data.flags =3D MMC_DATA_READ;
> +		data.timeout_ns =3D NSEC_PER_SEC;	/* 1 second */
> +
> +		data.sg =3D &sg;
> +		data.sg_len =3D 1;
> +		sg_init_one(&sg, data_buf, sizeof(data_buf));
> +		memset(data_buf, 0, sizeof(data_buf));
> +		mmc_wait_for_req(mmc, &mrq);
> +
> +		if (!cmd.error && !data.error &&
> +		    !memcmp(data_buf, tuning_block_pattern, sizeof(data_buf))) {

This memcmp is broken, sizeof(data_buf) is likely not what you want,
maybe you want 'size'?  Same thing for sg_init_one()/memset() above.

=46rom sparse:

drivers/mmc/host/sdhci-msm.c: In function =E2=80=98sdhci_msm_execute_tu=
ning=E2=80=99:
drivers/mmc/host/sdhci-msm.c:461:53: warning: argument to =E2=80=98size=
of=E2=80=99 in =E2=80=98memcmp=E2=80=99 call is the same expression as =
the first source; did you mean to provide an explicit length? [-Wsizeof=
-pointer-memaccess]
       !memcmp(data_buf, tuning_block_pattern, sizeof(data_buf))) {

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
