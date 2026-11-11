Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400693;
	b=vh5G+D5q1j95CIl8czSHWpsiNRSux+Stx3BHVOgdVmv4n683T85sAYSTx7Y7o+RWKIGb
	 AwQPRqtRGtqn1RVLtdcxg7YoyNcQku5GyTuTkfNc2IzW8fGMMUuZLL3DH5gxtTWX+Ada+
	 UkAa0nuWVvUpMPKmMrPEpnD9l3bI3eIY3TbU6Te01aaNi77YtFQAtTbN04e2/3NKlGSW8
	 ptf2vmUSGlV8osGtJqTFqYBL/Yhd6TSRsnktH96X8WHNUQiUMY5hOOnp8rXL0DzAbe8qU
	 XcN0s+bfqc6Tn+RkmhOaMbXek+xWyz5BX1m1YeIVFslpWtgWAeOVT63YWbVoNs5i7NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400693;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=N/aRmjV7cFcArA6Vo1LK5MJrHqjUEekZ6x7SBzSyzqg=;
	b=F+KWnb1X6uFw6zmSk0XF/suC/552dhXnEEeqvjh7MKmzG47loYgzjExYpTNHmpjM08ca
	 O/tTvDxZJaIbsvVa5Nez56ryuKubJGClJiZtKNkigagPQ/0mcD0JfKZaqE9SR0x7mw81B
	 E05Q9dATMxd/cOEkaky/6BA8w944JGscxBvRUl6g/YPbR2Q2S2RtrIihECTHcSb6EMoLK
	 2pXF+vYAdx/Nu9ys74ywfFYKhHcyvcvqFPF9qJY2bAg3XCoYk8YsXEevIMsa/UMeP+Vx0
	 p5W8Lj0RlZXWy0+QkU89aJmn9m+WvD7bBdGSOAjdYHs/5GI+XNeXbg2r5PsGNRwbbjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gFVp+Ac4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmJof+9l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB94606A327
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB94606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gFVp+Ac4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmJof+9l
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYmsn1358959
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N/aRmjV7cFcArA6Vo1LK5MJrHqjUEekZ6x7SBzSyzqg=; b=gFVp+Ac4kRHnINFN
	2Gxzh3Ia932399gYojdmLddB7NhIAu1oXhA2JDP/wn3OFqDmsIoWWcL0djWCrJgT
	iIN+lACHrY4/NwEeHH/0H4W+ky1BaPiUc5av/lxGC3oSz+Xm3sz3r1EccMINd2XZ
	wBrkvlAIu/b9irr9+ZcUcY8ClbnvVB2UePBc5rcdjHNCOAPtk0ZXsoZuk85KnQxK
	jsChlJc1HKtlhz7g/D+usVqsitC0497NApjpqUXHDRIktBNFye9bBr5QzyqZ4/IC
	TllwhmkeYLrTSiutbHh1mlelgFmHFrfs8LbCa2vy9qc8l7CvN+UkWE1jSBQyF3xG
	yHqWAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7ps8x6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so3427627a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 04:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400692; cv=none;
        d=google.com; s=arc-20260327;
        b=adU5FPssoMbDRAP803ISZIf9WGcbNLf+0tZmKKFLIgvTBSSNjLojgiOYgEKPxOFDWQ
         kGCb8Q6TiVE3CKfy7X6dfSwz7BsR07tiyRr4IR7WM6B3Rg6zUl9EOIuQ4nQWYja4Bbsh
         tYem1h2ibY65JTslSvDKCq+fTiDxbR0VeAaGPxx5Wh+NfSCT4QNXTi190TNk1JJcT6yu
         yDsiETNPrmSDaDUwg7xcrG56+klPh6n70WnRJ7I5mQLW465p0j8nhtPkCNG0YuQh5CBc
         6zQI81/Zef/SATcTu++h7EwumI0i16mKZaih1sPHBWF9m3RNin+IYCBaKuFEv2e1lbWO
         yKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/aRmjV7cFcArA6Vo1LK5MJrHqjUEekZ6x7SBzSyzqg=;
        fh=IOjCfBbtE8rLr7ZuyPIDt50aluDcD/uXrJS5TkuQGyI=;
        b=WVB3gyNhmWNgeoZCQ43fGQ6L3XbzxuFJxs5dJVwdb5c4kcOBg49F9hr15Ziq7HIY1v
         Gv80wRpj2TO2spJYpeAZ7lYxC0ZV6FrVyqRECAeW2RQvQW2lkT3wlmF9WXfBA7ZJmyUD
         PYYcHhnXshtT+Ud6vy0xG8sHJdLZPMCelAARRCO/JPYp5vKPeRSEux9lQodMYya7h17p
         G52s1Z9kEke6cSjc7tbAAxCbRGLT/pKP7vsWc22g1q5n5tCdnj0JajkHrrXu0a+5QQl7
         iIWI/jb0b2rVBR4sgg441Rn0VJsNhwzQHg9bLVGwUSCFs70dRCvYIWnIu1ONwZzDq08a
         Dx3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400692; x=1795005492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/aRmjV7cFcArA6Vo1LK5MJrHqjUEekZ6x7SBzSyzqg=;
        b=JmJof+9lNArolaJU8MZhpGNpN//8Nxgp4dQ9vnxEXvCr1lmhLSzoUQwdQcdyuV8OdP
         AqBUcxwc5TfGxPV87WqUSoavMB7sXPAongKU1G7sE/M7AOWGraBEShC5yBh5QNYtUOQM
         84Mv5KcuCkDcrGbV3Re5qua27aJnUX8mb85zJKfsJsIrQMsrU90OaqjzEq+ZPgRN3orE
         W+CxeE/7ljizuP68+KS1RU78Yqn/GPTEqsF1VRWElYA153AUMgv/Ku2Lx2SQv2NC7T0A
         aH4bLBqQsLnTeDVdTd2nCnjcf4zhPfio43B3F+FD7xFqGqCl00t83wXA1At/xxDkBbpB
         q0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400692; x=1795005492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/aRmjV7cFcArA6Vo1LK5MJrHqjUEekZ6x7SBzSyzqg=;
        b=ATtsr7Cx1l9r/71pfOXJqSe+oE76TEsoiNhM/HP1kV3yQDQ21Qmqw6+aRjj/ofWLaR
         dJuV0Y+fYCC+hI5kZ1UdbWGoTmRz3GACSaF7Mjrx8gUCqCc/G7HW1IBnyqhExb8rsYww
         9UAdhA9cmxADRE7bwQO3t07LkZb3ZF0ApkuLxlFDKby/X+iA4YiV0Fkga6JZSfq4q6n+
         ohG61KWcKGv7DI2LNoEaiEg9G7hF4CFueG9q0E8bkOX5J/qzK+tUZhwBHhCBVytgwRw/
         nHb/DkJN0O6s6sixZ1AZMvdwus8L0KDO7+BaLb9Rr0xlUn86F8cosEI5pbE5yvYcnaGT
         ebKg==
X-Forwarded-Encrypted: i=1; AL+hErFTh1sz+A1nhTYwhE321KA1yjlflws43Ny/lHhhkuFEaJMWdXsAp4ZWIs2/oTzXtIbSPoQYMN7HCiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zEstdZyZEvPjHrf3n1cOV1LIHdFvjvgby1PTb8I6k3fsUYZRa
	AAiUcIzlVJRnWYWSKs8VRnYb0yMF+NQjQfrim/n7xqgYPXrt9SxB7HcZXaBXrq2vO0vCNCTm/lA
	xeui37n8DlT5uL/BVP8dcfrFztQPnLfRCrJ2KkNuGTAr7LPzR7iFHjBWb1cfYS8b97uJI7gnGPp
	XH84mNynjoF/L7w9m1nlfNUsAzfzCBtJRlIvywnQ==
X-Gm-Gg: AYBFou00iFsQgHf0qCjXE63Tsk+qK2jw35WPBJWROLVBvWuiJoaW4s+af4tkep3O1Nd
	Jnwp+fIKF1dVVHAUDGRG4tA01RrIKW0afr026bjK4PkMkXrCPnILmUk8qffg/0/X/1Sgyn1qoEf
	2CRnqZA4as8Ps1Y50vjYqnkLwyiOCL0dWWuNm72h2WSAV5wFP2/L8X1MLt5A==
X-Received: by 2002:a17:90b:4f43:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3b182ed93b9mr2269247a91.28.1794400691884;
        Wed, 11 Nov 2026 04:38:11 -0800 (PST)
X-Received: by 2002:a17:90b:4f43:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3b182ed93b9mr2269224a91.28.1794400691415; Wed, 11 Nov 2026
 04:38:11 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104193521.1488192-1-matthew.schwartz@linux.dev>
In-Reply-To: <20261104193521.1488192-1-matthew.schwartz@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:38:00 +0100
X-Gm-Features: AclHuK8Wl6w7WfkH27qfSdFdd9nhOmyzBOg2pz93Kf5iIkFUVMWyceq0qKzLxFY
Message-ID: <CAPx+jO_Hn3XWNvd9u-t=Ra7WNgAjHn0vKU=ioBFWNaJ+-zEC1A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II wakeup
 before LPM
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: adrian.hunter@intel.com, ulfh@kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Lucas Lai <lucas.lai@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXxETyxRfHSTq1
 O61Sd3YhIYNqTmWITX729ITMkD+edRquIPS58mV8CtyZOdLQC/6AP4HpUk5uOnwR7pmlRX0+lUA
 SjVVhgBXfJUVyii7sBaC7Ou9IcY/2q0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX+UeXaVZnbLQB
 AVSwRAFaJXd8Cyrxtcz55KOjkI+dOiDbgrU/LXkrqBWFcNYNEgqK6pwMcI/VSgaPKwq2LR0oIYo
 Wgb7/Dh2v0owdpisNISC3zEeNlh3tbQm5ylplxI83q10aIQCsmtbhtBK5bSc79mUg/HqfayZ3yW
 DBf2pAqvhfxrX7s53pNC1pe67BaFI1CNrqJw5UZXGpO6PwAgMB8XqY9J8gaKi7qZGYgKIgmtBqY
 wPhcx2dD00JKLA5Lt6OVXsaR1zBjFgX71I8EUGV83Z3r/FP7vPikbsMTahwYVimnlHgQUMSeSSx
 Zuf9xf+RhB2Im7J1xLAKzayPW8LUOPrcK0Clob+xcCUTtSijf2OQqvqnt0YggUF0OQqdEURGQ8q
 iFW/BJbW/CeOoyD2jZCrHRA3Y7fDV/URyFv/JBbT7GEephhUk/whlMVu3Pq9xINuYZgxvvXK1hO
 +C2tRYWz+qq1JBNDRDA==
X-Proofpoint-GUID: GsJXPgNHEa0FAAvOxfz6w7n3No0gbC0M
X-Proofpoint-ORIG-GUID: GsJXPgNHEa0FAAvOxfz6w7n3No0gbC0M
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af461b4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=MTqqJCi6AAAA:8 a=QyXUC8HyAAAA:8
 a=k1VgLetk2nvzqEboKn0A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Ezp7Wq9ZhlihhAROVjRg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050

On Wed, Nov 4, 2026 at 8:35=E2=80=AFPM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> sdhci_gl9767_set_clock() re-enables low power negotiation right after
> releasing the UHS-II PHY reset. If the bus then goes idle before the
> UHS-II wakeup has finished, every SDHCI MMIO read returns all-ones for
> about 250 us. sdhci_uhs2_interface_detect() takes that as IF_DETECT and
> LANE_SYNC set, so a UHS-I only microSD card is treated as UHS-II. The
> attach then either fails with "SDHCI_UHS2_CAPS_PTR(65535) is wrong" or,
> if the registers come back before the CAPS_PTR read, runs DEVICE_INIT
> 30 times with a 10 second timeout each and delays card detection by 5
> minutes.
>
> Bit 13 of the UHS-II Status register at config offset 0x8CC is
> UHS2_WAKEUP_ACTIVATE. It stays set for about 250-300 us after the PHY
> reset release. Poll it before re-enabling low power negotiation. With
> the wait in place 12 of 12 UHS-II probes of a UHS-I card correctly
> found no UHS-II interface.
>
> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
> Tested-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Rename the register and bit to PCIE_GLI_9767_UHS2_STS and
>   PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE as suggested by Ben, and the
>   helpers to match
> - Use read_poll_timeout() instead of read_poll_timeout_atomic() (Adrian)
> - Describe bit 13 by its documented name instead of the inferred behaviou=
r
> - Say "wakeup" instead of "PHY" in the subject and description to match
> - Link to v1: https://lore.kernel.org/all/20261021233313.247155-1-matthew=
.schwartz@linux.dev/
>
>  drivers/mmc/host/sdhci-pci-gli.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index b55618566d651..263bb091374be 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -205,6 +205,9 @@
>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN             BIT(6)
>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN      BIT(10)
>
> +#define PCIE_GLI_9767_UHS2_STS                         0x8CC
> +#define   PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE         BIT(13)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL                                    0=
x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                       =
 GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE            =
 GENMASK(15, 12)
> @@ -1190,6 +1193,27 @@ static void gl9767_set_low_power_negotiation(struc=
t pci_dev *pdev, bool enable)
>         gl9767_vhs_read(pdev);
>  }
>
> +static u32 gl9767_read_uhs2_sts(struct pci_dev *pdev)
> +{
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_STS, &value);
> +
> +       return value;
> +}
> +
> +static void sdhci_gl9767_uhs2_wait_wakeup(struct sdhci_host *host)
> +{
> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       if (read_poll_timeout(gl9767_read_uhs2_sts, value,
> +                             !(value & PCIE_GLI_9767_UHS2_STS_WAKEUP_ACT=
IVATE),
> +                             20, 10000, false, pdev))
> +               pr_warn("%s: UHS-II wakeup did not complete.\n", mmc_host=
name(host->mmc));
> +}
> +
>  static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool as=
sert)
>  {
>         struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> @@ -1276,9 +1300,12 @@ static void sdhci_gl9767_set_clock(struct sdhci_ho=
st *host, unsigned int clock)
>
>         sdhci_enable_clk(host, clk);
>
> -       if (mmc_card_uhs2(host->mmc))
> +       if (mmc_card_uhs2(host->mmc)) {
>                 /* De-assert reset */
>                 sdhci_gl9767_uhs2_phy_reset(host, false);
> +               /* Low power negotiation during UHS-II wakeup makes MMIO =
read all-ones */
> +               sdhci_gl9767_uhs2_wait_wakeup(host);
> +       }
>
>         gl9767_set_low_power_negotiation(pdev, true);
>  }
>
> base-commit: 4df4d2a577db2d3d57b888bcfb1206fc74661d16
> --
> 2.56.0
>
