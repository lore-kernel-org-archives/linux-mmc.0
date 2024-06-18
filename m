Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17313B583;
	Tue, 18 Jun 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707671; cv=none; b=WtgjULORQa3/u3DqSCPD/1PrMkC81qm4Y8DxFbADqMboMtQ3eUqd3Lgs+fJzpQzbQqaTK/r1XkmeeTAEnyMByNd9zSLb2Wj7hCntD8iDvzcpgdTBKWl57FVge3sAcMr5MSRNmmfEaCItt10ATMSoJ/+JB/2X8Ufv3mOC88o5mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707671; c=relaxed/simple;
	bh=rvjI+WreJvA8E1gYVDuIFkf5JkNfBs4TdXYVsCkr4sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmqS3YS8yu6FpknI/li7xrbWG1AVj0ddU+p5SMJ9cBOrj8d+JByRRxJ6iMekcT6j/SgTP4Hq6MilqZ80Yk2lEHzS1Pw/ocayMFJYbpdt4S0KCqW26SF2Aw0hP/P7Thhm1ZVg97kU1lnaQwFU7MzLPybS8/mUpSpluDsuwMJPnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYtJEAZF; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYtJEAZF"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4eaf67ad82dso1818195e0c.1;
        Tue, 18 Jun 2024 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718707668; x=1719312468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O5E6uFMCzch60aofWs2yX/vE22i/qEJt7k+QBRqPJU=;
        b=cYtJEAZFbeflkx/487ZNhMHXj0cuhsNUv/aCcjp6NaWQFoPh8GBRU+xWwWQOrRKWJ/
         SZWJ/LoOLZb2y3YnLSOM3efY1upaKBIbN47mW2sOei2sscpaqsia5Ky6JX0LkKBGwP2V
         kamMyhi2MvHREeCuMjwMbSYeYKY1DSLiZ539Ekg5+dkBSpNvRm2VdRVIkju+H3HTgC3s
         fyh97lfr757MRYMT76bpGbhlFdC1iudhqFUdjqV2cAJg9fGblG1sr5I8NBYdW8PymUvv
         tpjdDHpvZGt+zTTIyKj2MhcbVcvHiEiHyid8rebVKofAq3jtSmminwz7FeDcJcbHBQwc
         oeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707668; x=1719312468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O5E6uFMCzch60aofWs2yX/vE22i/qEJt7k+QBRqPJU=;
        b=T7gmuGTEWESM3IzbYCebC996GtoVCbAPpYMyT3R7tlMv52o+I8lnSWqWX3a6earGac
         w+T0LC3h0a8sByNIQ8B/hvvWHUb79DxAPe9nD8iKy2wPrb052q3ByXjhMAuG4IoxysAF
         Lh6mQO2cMPnsMcjB8AT5jL72IcybVVChdImrQAh5P9YTr6qb9dgwvhBPQtMoaSJ53e2g
         qQ3b5oYJuMtJwxHeT1TUxQfPALdGIHellWrL49+eYXdkbeOl6MSi2zqiAgGMfRmmtYa4
         Uq1ywXDIUQ+h25TRU6fFpTURi+ePFAqZHeWokMLXcgaxxQrU1XI9Fz43/OMwceJPLV3N
         JqMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAWjAzPwTmuzAgH659R7Y4aEtLC1reJXQ++pAMvp/YWminboROjRGzJLJG9zl3x8O/7CA0FKzzBwKmNqAgVO19Y6Z+mRcNbRa4sOsB
X-Gm-Message-State: AOJu0Yz51b7Nu5ryURA43YtxCNEfBW896fE+cxl0+QSzCqwvq8wp3CNe
	pUIgMMnAR9ri+tUoJwi/XEGUw2LevJDgi7mDSIkVZjEKfl5Prl7uFZ/lpvRWEgbE892LjdCHcZZ
	bC4/7/vH5TwIOGSaGJ/sJ73/+Gv0=
X-Google-Smtp-Source: AGHT+IEZvG2k9nZHflFAyxpBhSmL2p58M9EBoQ7iVfMZsH7/KVOCzOnM+4ciE+xwHFVQ4LgpFYWB9GS0faKB1BxH0CQ=
X-Received: by 2002:a05:6122:c9f:b0:4dc:b486:e4a5 with SMTP id
 71dfb90a1353d-4ee3bab968amr11056936e0c.0.1718707668063; Tue, 18 Jun 2024
 03:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com> <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
 <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com>
 <84c57084-eb9d-4d11-9c2f-2a4ded6290c6@intel.com> <CAK00qKAHuLKGtcUnv=pKyQ4bKe+HqM1rFCQMRxPrGH9Aeat6Qw@mail.gmail.com>
 <3020280e-5e00-48f2-ae67-2260129ead9c@intel.com>
In-Reply-To: <3020280e-5e00-48f2-ae67-2260129ead9c@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Tue, 18 Jun 2024 18:47:36 +0800
Message-ID: <CAK00qKBMT8PkeLcuXhKWGPOgpU7y=RZ1JyM-P_mhPM7Rt9KVQQ@mail.gmail.com>
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error Recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:04=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 9/06/24 21:40, Victor Shih wrote:
> > On Fri, May 31, 2024 at 7:23=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 31/05/24 13:31, Victor Shih wrote:
> >>> On Fri, May 24, 2024 at 2:54=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> >>>>
> >>>> On 22/05/24 14:08, Victor Shih wrote:
> >>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>>
> >>>>> Add UHS-II Auto Command Error Recovery functionality
> >>>>> into the MMC request processing flow.
> >>>>
> >>>> Not sure what "auto" means here, but the commit message
> >>>> should outline what the spec. requires for error recovery.
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>>      I will add instructions in the v17 version.
> >>>
> >>> Thanks, Victor Shih
> >>>
> >>>>>
> >>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>> ---
> >>>>>
> >>>>> Updates in V16:
> >>>>>  - Separate the Error Recovery mechanism from patch#7 to patch#8.
> >>>>>
> >>>>> ---
> >>>>>
> >>>>>  drivers/mmc/core/core.c    |  4 ++
> >>>>>  drivers/mmc/core/core.h    |  1 +
> >>>>>  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++=
++++
> >>>>>  include/linux/mmc/host.h   |  6 +++
> >>>>>  4 files changed, 91 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>>>> index 68496c51a521..18642afc405f 100644
> >>>>> --- a/drivers/mmc/core/core.c
> >>>>> +++ b/drivers/mmc/core/core.c
> >>>>> @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *ho=
st, struct mmc_request *mrq)
> >>>>>       while (1) {
> >>>>>               wait_for_completion(&mrq->completion);
> >>>>>
> >>>>> +             if (host->ops->get_cd(host))
> >>>>> +                     if (mrq->cmd->error || (mrq->data && mrq->dat=
a->error))
> >>>>> +                             mmc_sd_uhs2_error_recovery(host, mrq)=
;
> >>>>
> >>>> There are several issues with this:
> >>>>
> >>>> 1. It is not OK to start a request from within the request path
> >>>> because it is recursive:
> >>>>
> >>>>    mmc_wait_for_req_done()                      <--
> >>>>       mmc_sd_uhs2_error_recovery()
> >>>>          sd_uhs2_abort_trans()
> >>>>             mmc_wait_for_cmd()
> >>>>                mmc_wait_for_req()
> >>>>                   mmc_wait_for_req_done()       <--
> >>>>
> >>>> 2. The mmc block driver does not use this path
> >>>>
> >>>> 3. No need to always call ->get_cd() if there is no error
> >>>>
> >>>> It is worth considering whether the host controller could
> >>>> send the abort command as part of the original request, as
> >>>> is done with the stop command.
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>>      1. It looks like just issuing a command in
> >>> mmc_wait_for_req_done() will cause a recursion.
> >>>          I will drop sd_uhs2_abort_trans() and
> >>> sd_uhs2_abort_status_read() in the v17 version.
> >>>      2. I have no idea about this part, could you please give me some=
 advice?
> >>
> >> The mmc block driver sets the ->done() callback and so
> >> mmc_wait_for_req_done() is never called for data transfers.
> >>
> >> That won't matter if the host controller handles doing
> >> the abort command, as was suggested elsewhere.
> >>
> >>>      3. I will try to modify this part in the v17 version.
> >>>
> >>> Thanks, Victor Shih
> >>>
> >>>>> +
> >>>>>               cmd =3D mrq->cmd;
> >>>>>
> >>>>>               if (!cmd->error || !cmd->retries ||
> >>>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> >>>>> index 920323faa834..259d47c8bb19 100644
> >>>>> --- a/drivers/mmc/core/core.h
> >>>>> +++ b/drivers/mmc/core/core.h
> >>>>> @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
> >>>>>  int mmc_attach_sd(struct mmc_host *host);
> >>>>>  int mmc_attach_sdio(struct mmc_host *host);
> >>>>>  int mmc_attach_sd_uhs2(struct mmc_host *host);
> >>>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_r=
equest *mrq);
> >>>>>
> >>>>>  /* Module parameters */
> >>>>>  extern bool use_spi_crc;
> >>>>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.=
c
> >>>>> index 85939a2582dc..d5acb4e6ccac 100644
> >>>>> --- a/drivers/mmc/core/sd_uhs2.c
> >>>>> +++ b/drivers/mmc/core/sd_uhs2.c
> >>>>> @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host=
)
> >>>>>
> >>>>>       return err;
> >>>>>  }
> >>>>> +
> >>>>> +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
> >>>>> +{
> >>>>> +     struct mmc_request mrq =3D {};
> >>>>> +     struct mmc_command cmd =3D {0};
> >>>>> +     struct uhs2_command uhs2_cmd =3D {};
> >>>>> +     int err;
> >>>>> +
> >>>>> +     mrq.cmd =3D &cmd;
> >>>>> +     mmc->ongoing_mrq =3D &mrq;
> >>>>> +
> >>>>> +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCM=
D |
> >>>>> +                       mmc->card->uhs2_config.node_id;
> >>>>> +     uhs2_cmd.arg =3D ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
> >>>>> +                     UHS2_NATIVE_CMD_WRITE |
> >>>>> +                     (UHS2_DEV_CMD_TRANS_ABORT >> 8);
> >>>>> +
> >>>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> >>>>> +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> >>>>> +
> >>>>> +     if (err)
> >>>>> +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> >>>>> +                    mmc_hostname(mmc), __func__, err);
> >>>>> +}
> >>>>> +
> >>>>> +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
> >>>>> +{
> >>>>> +     struct mmc_request mrq =3D {};
> >>>>> +     struct mmc_command cmd =3D {0};
> >>>>> +     struct uhs2_command uhs2_cmd =3D {};
> >>>>> +     int err;
> >>>>> +
> >>>>> +     mrq.cmd =3D &cmd;
> >>>>> +     mmc->ongoing_mrq =3D &mrq;
> >>>>> +
> >>>>> +     uhs2_cmd.header =3D UHS2_NATIVE_PACKET |
> >>>>> +                       UHS2_PACKET_TYPE_CCMD |
> >>>>> +                       mmc->card->uhs2_config.node_id;
> >>>>> +     uhs2_cmd.arg =3D ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
> >>>>> +                     UHS2_NATIVE_CMD_READ |
> >>>>> +                     UHS2_NATIVE_CMD_PLEN_4B |
> >>>>> +                     (UHS2_DEV_STATUS_REG >> 8);
> >>>>> +
> >>>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> >>>>> +     err =3D mmc_wait_for_cmd(mmc, &cmd, 0);
> >>>>> +
> >>>>> +     if (err)
> >>>>> +             pr_err("%s: %s: UHS2 CMD send fail, err=3D 0x%x!\n",
> >>>>> +                    mmc_hostname(mmc), __func__, err);
> >>>>> +}
> >>>>> +
> >>>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_r=
equest *mrq)
> >>>>> +{
> >>>>> +     mmc->ops->uhs2_reset_cmd_data(mmc);
> >>>>
> >>>> The host controller should already have done any resets needed.
> >>>> sdhci already has support for doing that - see host->pending_reset
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>>      I'm not sure what this means. Could you please give me more info=
rmation?
> >>
> >> sdhci_uhs2_request_done() checks sdhci_needs_reset() and does
> >> sdhci_uhs2_reset().
> >>
> >> sdhci_needs_reset() does not cater for data errors because
> >> the reset for data errors is done directly in what becomes
> >> __sdhci_finish_data_common().
> >>
> >> You may need to:
> >>  1. add a parameter to __sdhci_finish_data_common() to
> >>  skip doing the sdhci reset and instead set
> >>  host->pending_reset
> >>  2. amend sdhci_uhs2_request_done() to check for data error
> >>  also to decide if a reset is needed
> >>
> >
> > Hi, Adrian
> >
> > If there is any mistake in my understanding, please help me correct it.
> > My understanding is as follows:
> >
> > static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> > {
> >       ...
> >       if (sdhci_needs_reset(host, mrq)) {
> >             ...
> >             if (mrq->cmd->error || (mrq->data && mrq->data->error))
> >                   sdhci_uhs2_reset_cmd_data(host->mmc);
> >             ...
> >       }
> >       ...
> > }
>
> Like this:
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.=
c
> index 47180429448b..3cb5fe1d488c 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -581,7 +581,7 @@ static void sdhci_uhs2_finish_data(struct sdhci_host =
*host)
>  {
>         struct mmc_data *data =3D host->data;
>
> -       __sdhci_finish_data_common(host);
> +       __sdhci_finish_data_common(host, true);
>
>         __sdhci_finish_mrq(host, data->mrq);
>  }
> @@ -932,6 +932,12 @@ static void sdhci_uhs2_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
>   *                                                                      =
     *
>  \***********************************************************************=
******/
>
> +static bool sdhci_uhs2_needs_reset(struct sdhci_host *host, struct mmc_r=
equest *mrq)
> +{
> +       return sdhci_needs_reset(host, mrq) ||
> +              (!(host->flags & SDHCI_DEVICE_DEAD) && mrq->data && mrq->d=
ata->error);
> +}
> +
>  static bool sdhci_uhs2_request_done(struct sdhci_host *host)
>  {
>         unsigned long flags;
> @@ -963,7 +969,7 @@ static bool sdhci_uhs2_request_done(struct sdhci_host=
 *host)
>          * The controller needs a reset of internal state machines
>          * upon error conditions.
>          */
> -       if (sdhci_needs_reset(host, mrq)) {
> +       if (sdhci_uhs2_needs_reset(host, mrq)) {
>                 /*
>                  * Do not finish until command and data lines are availab=
le for
>                  * reset. Note there can only be one other mrq, so it can=
not
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ed55aab24f92..55f0db0fc007 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1563,7 +1563,7 @@ void sdhci_finish_mrq(struct sdhci_host *host, stru=
ct mmc_request *mrq)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
>
> -void __sdhci_finish_data_common(struct sdhci_host *host)
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_rese=
t)
>  {
>         struct mmc_command *data_cmd =3D host->data_cmd;
>         struct mmc_data *data =3D host->data;
> @@ -1576,7 +1576,9 @@ void __sdhci_finish_data_common(struct sdhci_host *=
host)
>          * conditions.
>          */
>         if (data->error) {
> -               if (!host->cmd || host->cmd =3D=3D data_cmd)
> +               if (defer_reset)
> +                       host->pending_reset =3D true;
> +               else if (!host->cmd || host->cmd =3D=3D data_cmd)
>                         sdhci_reset_for(host, REQUEST_ERROR);
>                 else
>                         sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
> @@ -1604,7 +1606,7 @@ static void __sdhci_finish_data(struct sdhci_host *=
host, bool sw_data_timeout)
>  {
>         struct mmc_data *data =3D host->data;
>
> -       __sdhci_finish_data_common(host);
> +       __sdhci_finish_data_common(host, false);
>
>         /*
>          * Need to send CMD12 if -
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 576b8de2c04e..5ac5234fecf0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -840,7 +840,7 @@ void sdhci_prepare_dma(struct sdhci_host *host, struc=
t mmc_data *data);
>  bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)=
;
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> -void __sdhci_finish_data_common(struct sdhci_host *host);
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_rese=
t);
>  bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cm=
d, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>                    unsigned int *actual_clock);
>
>

Hi, Adrian

Please let me confirm with you. Based on your above comments, will the
sdhci_uhs2_request_done()
be modified to option 1 or option 2?
After testing, when a command error occurs, only executing
sdhci_uhs2_reset() has no effect,
we need to execute the reset DAT Line and CMD Line. So option 3 has no effe=
ct.

option 1:
static bool sdhci_uhs2_request_done(struct sdhci_host *host)
{
      ...
      if (sdhci_uhs2_needs_reset(host, mrq)) {
            ...
            if (host->pending_reset)
                  sdhci_uhs2_reset_cmd_data(host->mmc);
            else
                  sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET);
            host->pending_reset =3D false;
      }
      ...
}

option 2:
static bool sdhci_uhs2_request_done(struct sdhci_host *host)
{
      ...
      if (sdhci_uhs2_needs_reset(host, mrq)) {
            ...
            sdhci_uhs2_reset_cmd_data(host->mmc);
            host->pending_reset =3D false;
      }
      ...
}

option 3:
static bool sdhci_uhs2_request_done(struct sdhci_host *host)
{
      ...
      if (sdhci_uhs2_needs_reset(host, mrq)) {
            ...
            sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET);
            host->pending_reset =3D false;
      }
      ...
}

Thanks, Victor Shih

> >
> > I have another question. the sdhci_uhs2_request_done() belongs to the p=
atch#18.
> > Can the above content be modified directly in the patch#18?
> > Or does it need to be separated into another patch?
>
> Please update the existing patches.
>
> >
> > Thanks, Victor Shih
> >
> >>>
> >>> Thanks, Victor Shih
> >>>
> >>>>> +
> >>>>> +     if (mrq->data) {
> >>>>> +             if (mrq->data->error && mmc_card_uhs2(mmc)) {
> >>>>> +                     if (mrq->cmd) {
> >>>>> +                             switch (mrq->cmd->error) {
> >>>>> +                             case ETIMEDOUT:
> >>>>> +                             case EILSEQ:
> >>>>> +                             case EIO:
> >>>>> +                                     sd_uhs2_abort_trans(mmc);
> >>>>> +                                     sd_uhs2_abort_status_read(mmc=
);
> >>>>
> >>>> What is the purpose of sd_uhs2_abort_status_read() here?
> >>>> It is not obvious it does anything.
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>>      sd_uhs2_abort_status_read() seems to only have read status,
> >>>      I will drop this in the v17 version.
> >>>
> >>> Thanks, Victor Shih
> >>>
> >>>>> +                                     break;
> >>>>> +                             default:
> >>>>> +                                     break;
> >>>>> +                             }
> >>>>> +                     }
> >>>>> +             }
> >>>>> +     } else {
> >>>>> +             if (mrq->cmd) {
> >>>>> +                     switch (mrq->cmd->error) {
> >>>>> +                     case ETIMEDOUT:
> >>>>> +                             sd_uhs2_abort_trans(mmc);
> >>>>> +                             break;
> >>>>> +                     }
> >>>>> +             }
> >>>>> +     }
> >>>>> +}
> >>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>>>> index fc9520b3bfa4..c914a58f7e1e 100644
> >>>>> --- a/include/linux/mmc/host.h
> >>>>> +++ b/include/linux/mmc/host.h
> >>>>> @@ -271,6 +271,12 @@ struct mmc_host_ops {
> >>>>>        * negative errno in case of a failure or zero for success.
> >>>>>        */
> >>>>>       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_o=
peration op);
> >>>>> +
> >>>>> +     /*
> >>>>> +      * The uhs2_reset_cmd_data callback is used to excute reset
> >>>>> +      * when a auto command error occurs.
> >>>>> +      */
> >>>>> +     void    (*uhs2_reset_cmd_data)(struct mmc_host *host);
> >>>>>  };
> >>>>>
> >>>>>  struct mmc_cqe_ops {
> >>>>
> >>
>
