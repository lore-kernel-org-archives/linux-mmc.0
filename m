Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2A3F8EDA;
	Tue, 26 May 2026 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807256; cv=none; b=tXjcXXa2QoWd0fE5VrUD0dDDU661FTaUb+LuAZsVb027W7c1o75tzos3c8QkHVVamUqJ1Z7T6nxOF0KzEN/k51VF0Qhs+t/HFKnIA5PtCaH2oI6OeRCHRYySgwi5yit2qqu5LdNDGXwLYc8PcMMLtdC6vWBcxX3ZYcdojA01hnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807256; c=relaxed/simple;
	bh=2DRfxXU36BYPgfqvTG17wX7EBy71VhHXkRk0PK3DQEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8TzfhY/DAgh7qi+Noz184PVzw7OsRzF9ILvcRfoS+Af5LWFGsNL82yNRpY3Av4zrCY0QG4cf8JTtgzaX/A2Zn8E4ZNahdippdZS5JgYZBRzutJXVSf92Hml1tihV/wyJOiIRUgyjvLlx8OLStyUFd+YS3J5mBcHIHWqiUmMpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfEmsYMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfEmsYMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AFD1F00A3A;
	Tue, 26 May 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807254;
	bh=rBDH54hBBSEXkcSCgrKQh5pyfKV2K8yDYsYn2j/E1V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfEmsYMMRG9qUa+cshKYm+dmQ0UTkz4W7xv5Bc4F5yw84C4lWHXvpChiAvpQpruqs
	 thyMEBVl+KbWJsGI4HMfqTAOM8NnQcPCL9k7K13aWllvXcPymJv/8Ay8PG34UnRLuk
	 q2XsROryYkRXss2UkOkYFyyO8yusvKHlwAdBCLlrdTA3zdWikJAN2yILEbbygZOtAF
	 YGNzxAJki70M2ktBXwx8I23QN0IFr4sYy3gMYteUqYTdkIwo1PFhXij//MthLOjv3R
	 oJ4MkKUlZnxV94OISPU1fas0yNLB91YPracDg9ouRKYKRtN+VWF2KeksSwcsUk0vGW
	 PcJoCvTu0sjqw==
Date: Tue, 26 May 2026 16:54:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: qcom: Add Hawi compatible
Message-ID: <r6c7sdhuziox2hsefxn7mwsbbhnkoi3ao3cko4spf3773whlmx@gdmzjievatsg>
References: <20260520075445.2146152-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520075445.2146152-1-mukesh.ojha@oss.qualcomm.com>

On Wed, May 20, 2026 at 01:24:45PM +0530, Mukesh Ojha wrote:
> From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> 
> Document the compatible string for the SDHCI controller on the
> Qualcomm Hawi platform.
> 
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Btw, you forgot to CC linux-arm-msm list.

- Mani

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 695a95e8f35d..acbbbeb2be45 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -37,6 +37,7 @@ properties:
>            - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
>        - items:
>            - enum:
> +              - qcom,hawi-sdhci
>                - qcom,ipq5018-sdhci
>                - qcom,ipq5210-sdhci
>                - qcom,ipq5332-sdhci
> -- 
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்
