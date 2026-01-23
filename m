Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FD371075
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161158; cv=pass; b=PAs+NHWsK+vhcqvtSU2HYWse064wtrHp1JG2XaSPjO60bTbQ/iIYDBEyFTleTBshJzjlLlL+0Q9GIJj0P7Do1T/ojyyPMK+BelaPgfvOU18+8u8Ey3uKWufNo65eAohaVbU7qUzL7mZt7lVbtMt9sHilrZGvuJVTKAGxXL994Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161158; c=relaxed/simple;
	bh=E9sY73mzI8WIkjfDsoZWnuIR2fVyge0FFmizubuNHXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmN7LUIsXB6iud0YcGrV+MEgIoEa4yUHXLQWx25BEQiqQgmCMVGdN9QWxuNrr4FdaL34BiTxStMHhz0Xj6EdyxQbz9JFNujPjs6p4UN+Vp7s86edHvfNqoaYVkYA0SPkIBlSGvG2Edluw4h+qPWTpWhfwddCXfFYYFCe8EW+0GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jOq3pRio; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOq3pRio"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso2584283e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 01:39:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769161150; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc2FixYgZ+5+k497lcSXIa+oWq39WCG0cqiYctrkiVvC0o9oWAOAdLoB7FJuLlOcDl
         7RFxQsOGwr2xeT1dAfWs9THH3eRzI5CB52hpBE5OdAVx5Xbugbc6DgzGvq8oy47zPPDM
         QcMwBRXkdGE/+syrU6akLN3xa3iZtPWEwzPCK0UnoQBve8i6T21b16igN8cEy0FHo74y
         1emhZoPyQaM39iUcLx53URoQjMF8Z9tl6XNYk1Cgw21OGzXqUpX32E/UUh6gMI2FwzsP
         0qKvRxLfbzKZAZ9YpxGjFZbZuqIRzl9T95Xdb/p2YH7yrG3iPE5TIQz2FVV6BpGISz5e
         UlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rG52QXraaViSSSy0BOpcFpXuiB3xymU1NOmvEWWxI0g=;
        fh=tAps2YfZzdVbHnCsi9yVNKvLeJjXEN6jKd8E2VXHBnI=;
        b=aYkZZ4Vf0xvlWjioy5DoGUWnqhz1mSIs50zUkPCgZOkMY6rPifPSnuXuAmkdUuDXMs
         FktszC6uQmlhmnPXiH1su2jqRfIujA8zMrJ99WJNxt1uhLef7Ya85rwjIqzz/m9D6ZKi
         onDH7ExxShyC8nWDd6RGByAMR/fnjGp2GgLAQFv8mHdzVYEsUG3jBEYhpiINoKqfvCVn
         01j1Kf95r9H3/+9XZmP2fhgnyaK0hdlufWqESL5RAgE2cdvNIS9nFiJoQf+9bHOSiXo8
         D3NqaNMPL/o/VJy3R2w5njMo1LfEYU0SoyOzfgJh+kg5IG+EKSqXA+YQIMaID2NOjVPG
         RrtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769161150; x=1769765950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG52QXraaViSSSy0BOpcFpXuiB3xymU1NOmvEWWxI0g=;
        b=jOq3pRioWt9pVUiWulyxA+CNpHXtnKAoAL0ppF4VN7sPCybk7m9gew0c2Adp0rqVUR
         lijiw0lWA+byQBkz773d8e3pI5XH1MKkWVEjCuqKvzN4p/PPjhIVn9JKnpTPMQWubHXC
         3AM+9RAbCo5/Pjg21zUa9FrlF0DSxOcGUG6oHUk1BVcjiRwvaCwRqo+zVSleaKz+hmYk
         v7aJ01+H8tQ8tFQ53Q653T0TH3Q4IeBViHr0DhZGs+6U/8/GoxGsRLMbexKMqWyRV0oI
         vOo2h7DiTqNPsJbZdf8R8OezbWR7l1PZIPFsBZ1dRbQMigHaI2OELXG6pSoetg7JV6+q
         4M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161150; x=1769765950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rG52QXraaViSSSy0BOpcFpXuiB3xymU1NOmvEWWxI0g=;
        b=jq+TWsdPAFfbP1H3lBsLfbR78PZsClwTafRTZi2UIV0swaBAw8YBXOZt+fA7glxJdy
         2TLY7LhHvis1d7idGn++bfrJ+CWZDEia4pMnXumcSkcqq4naeOlSABGUdA9M75q+/vR5
         ONTcC13utt7vIqv0kA4zed6c4JwmTB8bftpOsBSmm/AN80JMlFJDp5yZVebuAjMyydDq
         jZxznJWcW14Ii+40zAa3aGP6qMnQOj1ruh5HG7CByqizllVH26f+EiWEGo3uxFNtiDWf
         qErW+TGkAPqUbtV4oiv4bmqgWjVTk7tPgJ+hx0pgw2hj3e9xDe/Z5T//Y16z3A6tkhMz
         j1tg==
X-Forwarded-Encrypted: i=1; AJvYcCU59Hio8OZCWAOGBVD2N2wisIRl+GhzgLrdj76a6w88MMKqnfg2Ii6WX6aBhhFeJI/VGJqppvLzO+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5p06uEIQ9DLWxIXAOGSXPDrpdk0y5x+sC9kmOFFcAkDOmBfA
	bkNPYibn87S9qeQX0uSl4ot5AzwQiMjfhy58bM94i/+zCztI4DXj7lWvQ8JrMRYQkEridDIuIha
	D/Oj1ibaeTPXDx/0LhFhWvK5FMJzrcLvs7p5ZJtG7XxmxMxgmud2m
X-Gm-Gg: AZuq6aJqkdYZRp/o11FwHflGZ8f1lFcDH0OYh7RofDkIxdUeBYqABo85Pd/3O47hG9h
	ws9W+nqa3qwyoGiBz3L66bhJnGD7jgPRAo1l9Irxo13y/td8Y38D1MLvvqmae7R9DQ2EfGj9zOv
	Sip2s6k2cr8pxuzUmWgihHJTT9CJ3cZnnCWxTCuPmYL0uSX7FfyZMw/sq0+PrKtZb6o3MPiY8Ar
	Opg3a9U8cmRZo95kujCzRCJLBl2tCtBIpJiFydbFRxRIre4EFwvE254gtQU7NY61h+7VTTm
X-Received: by 2002:a05:6512:61a6:b0:59b:b0f9:53ee with SMTP id
 2adb3069b0e04-59de48f39b4mr696019e87.7.1769161150160; Fri, 23 Jan 2026
 01:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126064251.1928529-1-quic_mdalam@quicinc.com>
 <CAPDyKFppNgYvHJDqfvyQ0DTYCwgcSR12D+-=04NGEDtbM8FmTA@mail.gmail.com> <3df0ad20-61c0-73c4-be8f-aea43f70cb69@quicinc.com>
In-Reply-To: <3df0ad20-61c0-73c4-be8f-aea43f70cb69@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Jan 2026 10:38:33 +0100
X-Gm-Features: AZwV_Qj-fRTlNB7M0mC81wCnKPw6IPYxZZexdPMmRUIdx1ZRPaLvBhXQXt4TZrg
Message-ID: <CAPDyKFpcGvhp82MTcN3wTeLrxErQC6Cficva341VVLWBf6zL9w@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-msm: Enable ICE for CQE-capable controllers
 with non-CQE cards
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, abel.vesa@linaro.org, 
	ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jan 2026 at 07:10, Md Sadre Alam <quic_mdalam@quicinc.com> wrote=
:
>
> Hi,
>
> On 1/21/2026 6:14 PM, Ulf Hansson wrote:
> > On Wed, 26 Nov 2025 at 07:43, Md Sadre Alam <quic_mdalam@quicinc.com> w=
rote:
> >>
> >> Enable Inline Crypto Engine (ICE) support for CQE-capable sdhci-msm
> >> controllers when used with eMMC cards that do not support CQE.
> >>
> >> This addresses the scenario where:
> >> - The host controller supports CQE (and has CQHCI crypto infrastructur=
e)
> >> - The eMMC card does not support CQE
> >> - Standard (non-CMDQ) requests need crypto support
> >>
> >> This allows hardware-accelerated encryption and decryption for standar=
d
> >> requests on CQE-capable hardware by utilizing the existing CQHCI crypt=
o
> >> register space even when CQE functionality is not available due to car=
d
> >> limitations.
> >>
> >> The implementation:
> >> - Adds ICE register definitions for non-CQE crypto configuration
> >> - Implements per-request crypto setup via sdhci_msm_ice_cfg()
> >> - Hooks into the request path via mmc_host_ops.request for non-CQE req=
uests
> >> - Uses CQHCI register space (NONCQ_CRYPTO_PARM/DUN) for crypto configu=
ration
> >>
> >> With this, CQE-capable controllers can benefit from inline encryption
> >> when paired with non-CQE cards, improving performance for encrypted I/=
O
> >> while maintaining compatibility with existing CQE crypto support.
> >>
> >> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > This has been applied for next since a few weeks, but I have a
> > question. See more below.
> >
> > [...]
> >
> >>
> >>   drivers/mmc/host/sdhci-msm.c | 77 ++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 77 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm=
.c
> >> index 3b85233131b3..da356627d9de 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -157,6 +157,17 @@
> >>   #define CQHCI_VENDOR_CFG1      0xA00
> >>   #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN  (0x3 << 13)
> >>
> >> +/* non command queue crypto enable register*/
> >> +#define NONCQ_CRYPTO_PARM              0x70
> >> +#define NONCQ_CRYPTO_DUN               0x74
> >> +
> >> +#define DISABLE_CRYPTO                 BIT(15)
> >> +#define CRYPTO_GENERAL_ENABLE          BIT(1)
> >> +#define HC_VENDOR_SPECIFIC_FUNC4       0x260
> >> +
> >> +#define ICE_HCI_PARAM_CCI      GENMASK(7, 0)
> >> +#define ICE_HCI_PARAM_CE       GENMASK(8, 8)
> >> +
> >>   struct sdhci_msm_offset {
> >>          u32 core_hc_mode;
> >>          u32 core_mci_data_cnt;
> >> @@ -300,6 +311,7 @@ struct sdhci_msm_host {
> >>          u32 dll_config;
> >>          u32 ddr_config;
> >>          bool vqmmc_enabled;
> >> +       bool non_cqe_ice_init_done;
> >>   };
> >>
> >>   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct s=
dhci_host *host)
> >> @@ -2012,6 +2024,68 @@ static int sdhci_msm_ice_keyslot_evict(struct b=
lk_crypto_profile *profile,
> >>          return qcom_ice_evict_key(msm_host->ice, slot);
> >>   }
> >>
> >> +static void sdhci_msm_non_cqe_ice_init(struct sdhci_host *host)
> >> +{
> >> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> >> +       struct mmc_host *mmc =3D msm_host->mmc;
> >> +       struct cqhci_host *cq_host =3D mmc->cqe_private;
> >> +       u32 config;
> >> +
> >> +       config =3D sdhci_readl(host, HC_VENDOR_SPECIFIC_FUNC4);
> >> +       config &=3D ~DISABLE_CRYPTO;
> >> +       sdhci_writel(host, config, HC_VENDOR_SPECIFIC_FUNC4);
> >> +       config =3D cqhci_readl(cq_host, CQHCI_CFG);
> >> +       config |=3D CRYPTO_GENERAL_ENABLE;
> >> +       cqhci_writel(cq_host, config, CQHCI_CFG);
> >> +}
> >> +
> >> +static void sdhci_msm_ice_cfg(struct sdhci_host *host, struct mmc_req=
uest *mrq)
> >> +{
> >> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> >> +       struct mmc_host *mmc =3D msm_host->mmc;
> >> +       struct cqhci_host *cq_host =3D mmc->cqe_private;
> >> +       unsigned int crypto_params =3D 0;
> >> +       int key_index;
> >> +
> >> +       if (mrq->crypto_ctx) {
> >> +               if (!msm_host->non_cqe_ice_init_done) {
> >> +                       sdhci_msm_non_cqe_ice_init(host);
> >> +                       msm_host->non_cqe_ice_init_done =3D true;
> >> +               }
> >> +
> >> +               key_index =3D mrq->crypto_key_slot;
> >> +               crypto_params =3D FIELD_PREP(ICE_HCI_PARAM_CE, 1) |
> >> +                               FIELD_PREP(ICE_HCI_PARAM_CCI, key_inde=
x);
> >> +
> >> +               cqhci_writel(cq_host, crypto_params, NONCQ_CRYPTO_PARM=
);
> >> +               cqhci_writel(cq_host, lower_32_bits(mrq->crypto_ctx->b=
c_dun[0]),
> >> +                            NONCQ_CRYPTO_DUN);
> >> +       } else {
> >> +               cqhci_writel(cq_host, crypto_params, NONCQ_CRYPTO_PARM=
);
> >
> > Should we really call cqhci_writel() here, even if
> > sdhci_msm_non_cqe_ice_init() has not been called yet?
> >
> Thanks for the pointing this. The else branch is intentional.
> for plain requests we must clear the crypto registers, otherwise
> the ICE hardware would continue using the previous encryption context.
> ICE initialization is only required when programming an encryption
> context, so we don=E2=80=99t call sdhci_msm_non_cqe_ice_init() in the pla=
in
> path. Writing 0 to NONCQ_CRYPTO_PARM is safe without ICE init and
> ensures that subsequent plain requests are handled correctly

Thanks for clarifying!

Kind regards
Uffe
