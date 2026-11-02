Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628248;
	b=lWyaQGXtS6/f+RqCpA76jUrYzWc0u2EgKiBD9he8h+G+uDVO/X1aCpv9t5OpVEFHnUax
	 ldTYgYpIvpJW9fadj2MbAT+YnxyWzmTP8F5hqT2Pp9M5s6Q3RhKh4Ve5DlLa7nNMPQpNV
	 56NNEL3ONGO43tFMF4NYOdUO+X6vbVJi8gKkWGiJelHbwUzptw0av732XX8TEO/qgl4/Q
	 bl8MYUTV3H3WCSCnIlq0P6fAmfKwPiblZKZWqzkJ3joBV3QmjVYB/kGtXhrTBJvn0Q5ku
	 P6amhiGwBiBK4pYS1YtYGO+q/N7lI1/9VunQyHoaYrXgGBucA0zBmeOaq5sZYH6ZQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kj8Fda6uHscKvI7NgiMuoDqrKd7/WCO1xgYEpbK+uUM=;
	b=kbIlqVrFbZ8dW8hROFo+rfnv54o7+rPxUrCL5y+2gLSBoa0l2glPplSy3q5M8Nu0+ExE
	 HIt7zADf9VQDOgid35SEUUciWjPhrtMFx/5lchkbtaK77Pb4/R5Hc6wMiQtMlCQMayqd9
	 3N8VAE4rq6l3UZ4umW4mHcNEGS5BSzFwWqza0gEHaHc9Wo4A/3p1hvsVZAYkn925wWp3I
	 dSHH+yVXSa+Toszy0isGmzxUo98V+RzPWJMXqpo7JyZjxtNbFEsZbo0u7bQ3ClbMT5scD
	 OrzchpfbOcw70Hclx1clits6ysW9W7VqeXfHVbqbD6opOVFnoJknRKl+yDfrywTtrFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZrXfdHH8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ML33df1E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B460A261B
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 14:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 379B460A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZrXfdHH8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ML33df1E
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpQH5846145
	for <linux-mmc@vger.kernel.org>; Mon, 2 Nov 2026 14:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kj8Fda6uHscKvI7NgiMuoD
	qrKd7/WCO1xgYEpbK+uUM=; b=ZrXfdHH8+h939oqNvWMMRuf2TVYcTjeQJ6dsxy
	Q+phgL939WRtYs3GUxzjgdRoK5qwcKgCGj7zjFd75L+8EIy1t9ZtVcNTOwA8OPuS
	eV6htRKbdPeZQ+bLsUdsgbxAYCh4rR45nTWNxutmtvAHR9Zmhw8FdxUK/5/QKdiy
	AzW6vWbE2JeERHRsOEP5Fd92d3K0VydUkz2K/xrciWUK+PzAmZkGw4x52UDAbH2i
	xhljz4O1f0bMLD9rLmwlsNmlIDrcondlUWIB/e3ZVkKzdVNB5lmAzlHYbg99xvCV
	zuYW6ckTzYgFjJR4Vt2cNT/eFPF1KttOSFFGoE2mH41RaWvQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1sx2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 14:04:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89ff475a0deso2748133b3a.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793628247; x=1794233047; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kj8Fda6uHscKvI7NgiMuoDqrKd7/WCO1xgYEpbK+uUM=;
        b=ML33df1EAtM/4gakNWiF9tXCLNdHsKpHs/bnsVI8KA/3ZlCi40jjNv5dg0hKUgVRes
         trDX/9JjfPAaQxEuPHyUR/U7+8xDjRK/GGh7rKvfguFEOg5vOw78AlO1/4n7G1UZqYvv
         HTQDGecjrS98WIBRb/3gdX+C8+X4ilfVa7EBN1v/8LMvpTl6x/mRRBlk1VJe3xusb4FS
         n+G/9c6M5FaorFl5tbaXLRfF+RcYXk3FXYs2/JjmJ+j0ABtFZPFxMwCTEnKkbi0RKyFm
         MddqDONEdxE8hoCIx9QxC1SeOG/6PVlNl8S3GzeQ+KgbqRBnO3DsN0dnhHJilClryeeR
         q6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628247; x=1794233047;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kj8Fda6uHscKvI7NgiMuoDqrKd7/WCO1xgYEpbK+uUM=;
        b=IlMcDEcEuBAIFETyuXStltiGxewrkurF+SJQ9tYBEWT5BPgBkdtjB3xH7XAdSFkuWp
         bJOo8j31zem1q8/0QRsmFwigPYY4Tf8Dfzy6epxe/r60t+ns6jfWL0z5ToitEiwW81d1
         rR+/zseN17iyPzGu7WGqQEh1fICRGgwGyHdGiAERd4Xb59RbAXIGl224VqICimBLG7w1
         ynVJvjDVRIsm+a6dLfKblptRw2byt9CqCzFMpXpulaCHYJ+4ppmhzxl2JGyfMK1pYUwl
         RKN8XsuDxa+TABWYFhVmbCcYuOXrHcbyNm9dr7+/z5eqfbALBaMaxXfM6VR0h1n1hi7N
         0Kgw==
X-Forwarded-Encrypted: i=1; AKwUvBxpLeSwRc3ssRRwmFsMB7gsiaKjR0kUfwFIWNBq96/KzSQqQvtLGba3wg6qjY1XrUm+L8Fe/iTwmOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mecPE8sDWjTDDsCbVOVI6wQBrxIES4Ne7bkW7qtRFOHuoQOZl
	KZrt/T2puhshqxnHwCms5TMVZMvxmyTeCjV4JXvVwptoltqyd4UIGV5ANH7trZQX0uQ4pUvfYIT
	60UPLOPCy1MMAGRmVqAs0LvCsiu6dRbFshgMWh+94Ag+SE1pbadb8fWcIYwaAMiM=
X-Gm-Gg: AYBFou1GXho52/iZ7OiCR6OJZf1SP0dRPxEWVU5BV+NIBYadPRkpSnk8h48iD78lHK3
	pWzWCf7m1VXx2AZAfckrM1j7I1gwnmUIYS9+7rlELOlFV/ZPPBxg8stF4oqf3mcYGIWguvvySFR
	cy0VPMVhgFZq+OcEFEvWiVrLoTW17FECG3YcriwJkdKizjOBIghu5LpuqlZ5JxRNrkasre0XfA/
	FvTGT0MFLKtWeu8nZrwrX2IlC2VxCx61VJqy7275Yyl1iGw3FOebLgCtu/lGrIkYwMiue0fAsHY
	f/kxt9tZJKOV0+WfVPR3tO5LBxToJHcujVOG4CrXdnyJ+XSDjvPfQDxRvjfnB6yCteHLgW/mBGA
	Wi0b8iJYcFuO67hAFbx3gTGsEbS6G0iQYIEa7WqUPqzEbneEz9eWx7JODSX4FgU7spPVZlyBMr2
	8=
X-Received: by 2002:a05:6a00:12ce:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8a9bef522b2mr8213952b3a.59.1793628246625;
        Mon, 02 Nov 2026 06:04:06 -0800 (PST)
X-Received: by 2002:a05:6a00:12ce:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8a9bef522b2mr8213908b3a.59.1793628246113;
        Mon, 02 Nov 2026 06:04:06 -0800 (PST)
Received: from hu-ahari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd956sm2286942b3a.3.2026.11.02.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:04:05 -0800 (PST)
From: Anjana Hari <anjana.hari@oss.qualcomm.com>
Subject: [PATCH 0/2] mmc: sdhci-msm: Add firmware-managed resource support
 for Nord SDCC
Date: Mon, 02 Nov 2026 19:33:40 +0530
Message-Id: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyY6GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3eKU5OT44uTcTF3jZBPzpMREi5SkREsloPqCotS0zAqwWdGxEH5
 xaVJWanIJyACl2loAPCZ+um0AAAA=
X-Change-ID: 20261102-sdcc_scmi-3c47baa8dba9
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anjana Hari <anjana.hari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Ram Gupta <ram.gupta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: 1noglcgchl0yatl6zXEWexJdwfy2R-gf
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae89857 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cGx-myOgvVfTzkcdCuMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfXxGAimJrvDBfn
 2Y3tKrZq7P28OUm2snjDHX4oULATkKXep6WtoORpxNGNC8T/2esSGCpm8VQPMFDpKTvRpFG+k27
 dCbn8u+d/H3DGDvY+F3wSZakLDDGD5I4X9VeeYBluxA0v8HA+wfm15V63IBZzESgQXHK/rwZ/1c
 orr0su2hEmt7ubz/YdroRRyefYF6/JF05Dgez4HOOZ+Lcww913WGTWf4CRRgxtgV9U0ltAgUX68
 mhqsj7y5sMrSjVRBYDyBmwYFMNWwTuyzMEuekC4IBcMxtFKjVvc/jEmibMpALWF8Y2fruHefPYD
 eZ7yUJkNGH84WGuB7C/GV8m/MFQ0FireL5jrT/qollRldO8wiw0BOIiMnTs0fitAbeL0WAt970v
 +8x8Io7UNRq4DgCVrIaznG0RswK1m88l6Yx9QwrYBvTzRsZNPjH7zx+D7zPfgSLWjDadtb8xhdY
 Vk6iXL2jW1B/T6XA1/w==
X-Proofpoint-GUID: 1noglcgchl0yatl6zXEWexJdwfy2R-gf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfXzzaS79e3PT62
 c+RVKl7a21CvRe54jWDzJ81L4J644/zTqTOMB2+hWGDmXDvIyvZFC7Aj1z9GkXrVrrXi3ZX7Q1g
 UGHiQel0k+dW1/FzYAw9uok77vfChiM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020055

On certain Qualcomm automotive SoCs such as Nord, platform resources
including clocks, interconnect bandwidth, resets, and regulators are
owned and managed by firmware rather than directly by Linux. The
firmware abstracts these resources behind logical power domains and
exposes control through the SCMI power protocol.

This series extends the sdhci-msm driver to support this
firmware-managed model. Instead of directly programming GCC clocks and
PMIC regulators, the driver operates through two logical power domains:

  - "power": controls the SDCC rail. The driver requests power state
    transitions via pm_runtime_resume_and_get() / pm_runtime_put_sync()
    on the domain device, which are forwarded to firmware as SCMI
    power-state messages.

  - "perf": the SCMI perf domain driver dynamically registers the
    supported clock frequencies as OPPs by querying firmware at probe
    time. Clock rate selection uses dev_pm_opp_find_freq_floor() and
    dev_pm_opp_set_opp() on this domain.

Patch 1 adds the Device Tree binding for the new "qcom,nord-sdhci"
compatible string, documenting the two power-domain properties and the
absence of clock, interconnect, reset, and regulator entries.

Patch 2 introduces the firmware-managed variant in the driver. A new
sdhci_msm_fw_v5_var descriptor is added with its pd_data populated;
probe detects this and selects firmware-specific platform data and ops.
The new ops implement clock rate selection through the perf domain OPP
path and route suspend/resume through SCMI power-state transitions
rather than local clock and regulator management.

Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
---
Anjana Hari (2):
      dt-bindings: mmc: sdhci-msm: Document bindings for Nord SDCC
      mmc: sdhci-msm: Add support for firmware-managed resource platforms

 .../devicetree/bindings/mmc/qcom,nord-sdhci.yaml   |  89 +++++++++
 drivers/mmc/host/sdhci-msm.c                       | 213 ++++++++++++++++++++-
 2 files changed, 297 insertions(+), 5 deletions(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261102-sdcc_scmi-3c47baa8dba9

Best regards,
--  
Anjana Hari <anjana.hari@oss.qualcomm.com>

