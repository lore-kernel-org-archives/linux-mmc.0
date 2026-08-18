Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605943A5436;
	Tue, 18 Aug 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073151; cv=none; b=X/f+p2UGjaK/TbsYliUYkOpPDlWQvY+j9DoMK9Rt04RQYFJMZENFflZHBvmnGLAhOfePkfPls1wEwAF5Jx2lCJrX+X/g683LLmtrL9/JI4lIf6SUfH7rppm6J4SUWsQVQFUIzNo3An7I3l6H9G62qP/OkApbFIrlEWqKIMLJ1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073151; c=relaxed/simple;
	bh=km+06z1zZjsvET193diCdp1XZYNW91zhvBs+rcinbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfCe8q2hsYvj7V8ISg4FSSj8m0GnlXEBX7nfHlEb1u4ktk+cq6Ij+JBRsfgDiMTEDETSglGodmyma03CBU5zvaC3VfiCYtmUvB4IZjtiEqruHSmoplKmuYK1IcFYfOoi3SNr2TlMhYZRt/qHrECPDdNEKfiMnSim0enTqYD5moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csgiEA5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csgiEA5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E31F000E9;
	Tue, 18 Aug 2026 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073150;
	bh=EXKaeMDyyG/3gBUL3UZXwLwdxbFaiuHU+n74julUvzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csgiEA5vB0v0U8I95W4nxOSeWR6T9rEZ5p3S3kNm6tDswwmkDzKejewdZzYi5n+Di
	 Q4k4wb+QofhyDz1WFkrBJfXeEsjK/bNl3Xc3Srb/uBtyeks5NMpsI2sUonRyoGiYs/
	 m9MZ3qx4iV1b92U4KIPbbPM14NcOfq6nehavrGFhwezpMtteHqB612yzzD1xNZ2sjp
	 zTHviQ764LGwzP+dcTXYyV1rvmVsCtnwl2ATqJfwM62UO2zrPuHG+ROcN9CDdTfXfI
	 uPv68bNz/yZSqhIjSA/r1/y91Q1MjdlZnE7dFGV9/gM6ODlqtR/jjoSmHcfCjQ+sO9
	 /JF4uOF/7iWzw==
Date: Tue, 18 Aug 2026 10:12:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
Cc: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
	adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
	quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
Message-ID: <20260818171227.GA2249@quark>
References: <20260811151759.1258525-1-neeraj.soni@oss.qualcomm.com>
 <20260811151759.1258525-3-neeraj.soni@oss.qualcomm.com>
 <20260811190851.GC2895176@google.com>
 <877c20e3-625c-4ba8-beed-305393b18cfe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c20e3-625c-4ba8-beed-305393b18cfe@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 01:00:21PM +0530, Ram Prakash Gupta wrote:
> 
> 
> On 8/12/2026 12:38 AM, Eric Biggers wrote:
> > On Tue, Aug 11, 2026 at 08:47:59PM +0530, Neeraj Soni wrote:
> >> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> >>
> >> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
> >> needs to be restored when hibernation exits. ICE keys are re-programmed
> >> during sdhci_msm_ice_init() but it may not cover cases where the
> >> hibernation image is already restored.
> >>
> >> Unwrap the pm ops and use directly in driver to add the call to restore
> >> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
> >> same state as before hibernation.
> >>
> >> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
> >> keys is not needed during MMC runtime suspend/resume.
> >>
> >> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> >> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> >> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> >> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++++++++++-
> >>  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > So with this patch, resume from hibernation will be the *only* time that
> > ICE keys are reprogrammed.  Are you absolutely sure that is enough on
> > every SoC this driver supports?  What about resume from suspend-to-RAM?
> > CQE error recovery?  What if the hibernation image fails to be created?
> > 
> > - Eric
> 
> Hi Eric,
> 
> There are two scenarios where key would be required to reprogram, first is when
> rail powering the ICE goes off or SDCC does BCR reset.
> 
> now during suspend-to-RAM, rail powering the ice wont go off, so key would not
> be required to reprogram. During CQE recovery, key would be only lost when BCR
> reset is performed but that is not happening right now, to be taken up once its
> fixed as part of recovery flow. And in case hibernation image fails to create
> then device boots from normal flow where there is no need to reprogram the keys.
> 

Okay this patch should be okay then.  Seems that the commit message
needs some work though to properly explain this.

- Eric
