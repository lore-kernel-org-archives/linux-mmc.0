Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44501361DD5;
	Fri, 31 Jul 2026 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478493; cv=none; b=HiHxfeFxS7qfpaW+N5oPBvW9v7oOLdkxiTGJU90v8BuwJXLrR4pz43OQNUR0HtN+dgUhtK+F0aGVoCvOHY3TGdzBmOjpM3r2jqIOC0AjO9G7uv+Z9WZNJA9sg8m5xg5CZx7YPA6jiienaHP3yvhxuWFBzRJdv2/M9DIccmD3POg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478493; c=relaxed/simple;
	bh=qwy3EYPZwk1gO57BEU+L0PiKdu4aF3WNDvbLnh/JUxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIepk5r6I4SO780Ec6jAHr0joWYSYkv9KyzcPzLK9BsyI5OSlWBMmk4HJjheU85TpgzvUpXk4imIIbHVXkBAZ8ddb53TS1oFMUU/07286ZbHMAmqmJLoVITuu+wgHspPELuSZfzU1zakQooInJF4E5GDkQzyKDBe4kr6tcnTYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeboebCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeboebCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9211A1F000E9;
	Fri, 31 Jul 2026 06:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785478482;
	bh=4L4HY5zoX9bvWH/9FDlwSQ4tEHxtWY6GOLWts6m4kSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SeboebCyk3fxQBzifXTgmoGC9AixyPAUGiGkGUyq/zlC32jc/cR6VdcjuHYEkK0wR
	 rbLseLgUAXLL2SmbvhJdOWSv+4Bts6caWKaFqiyQkCARxGyJbc82Yom0+9Ox8vy7O3
	 kljiGghJjdPcXFvRspCP7AL5dF09efaZOQYdtxOl/9prWUU/fZF3ekZ1pnINulWh+Z
	 Se8AaWWJU9Xx3EixKKhpD4Xut2IpDwf7Ni81xnufVcbE2rIuZgjaaOFUUaejSkOK/r
	 fYUkcaOkdpoIWRQDRdWuildFwPmqovlj7mSJbQ8+lcodX06L8QCdtrU/N0yZK0DBvO
	 Al+MtXDBsr5GA==
Date: Thu, 30 Jul 2026 23:12:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mmc: sdhci-msm: Reprogram crypto keys during host
 hardware initialization
Message-ID: <20260731061246.GB57540@sol>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>
 <20260730191823.GD3139@sol>
 <6c795412-ab63-22f9-0b64-8bc746fc2773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c795412-ab63-22f9-0b64-8bc746fc2773@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:37:44AM +0530, Neeraj Soni wrote:
> 
> 
> On 7/31/2026 12:48 AM, Eric Biggers wrote:
> > On Thu, Jul 30, 2026 at 07:38:20PM +0530, Neeraj Soni wrote:
> >> Host looses the Inline Crypto Engine (ICE) keys during hardware reset.
> >> Re-program the keys while intializing ICE to ensure that ICE is available
> >> in the same state as before the hardware reset.
> >>
> >> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-program of ICE keys
> >> is not needed during MMC runtime suspend/resume.
> >>
> >> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> >> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> >> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index 4aff965f0e2e..7d71dc6f388d 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -1958,7 +1958,10 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> >>  				cap.sdus_mask * 512;
> >>  	}
> >>  
> >> +	blk_crypto_reprogram_all_keys(&mmc->crypto_profile);
> >> +
> > 
> > This still does nothing.  The crypto profile was just initialized, so no
> > keyslots are in-use and blk_crypto_reprogram_all_keys() does nothing.
> > 
> This is needed to address those scenarios where device is running in a
> stable state and only the host hardware goes for a reset, for example,
> to recover from an error state or stall.

Nope.  Please check the actual code.  This is called only at driver
probe time.  Again, the crypto profile was just initialized, and no
keyslots are in-use.  It is a no-op.  Maybe you intended it to do
something else, but that is not what it actually does.

- Eric
