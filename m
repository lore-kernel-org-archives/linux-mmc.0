Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31343C7C7
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553789; cv=none; b=K4PbyY6oEtvwZtRbGVruRaUNI8C8n6zehgWvz7qteebRgLR1SBS0uKwlSDjzLHSV0LA0MwTXPw8tYU8euFMBnGG18DS1T091aIV4Dor1slueHJ9MIDHYdJQiEQl0M6PgadQBAHfjgdfW6xEH4HQ74xG15CUrRx1EX+9nVOgo3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553789; c=relaxed/simple;
	bh=QrRFpsVnRAEyLk25Y4VGMdUOQlJ45UkMXhBUxRWWrnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rspLz0LveRgfWs7E428lRMzXrhJDUC4Gs/yTlRGeJA/mutYFYvaCSFoMni8k5w8jU0K4MWTkDfB2uMj1OUq3NFCCFaLS9xpIyJx/XDVEXFdiFyy83lNhOTWJnHYKECLMBVujEMVGyusVKI6WHbrnUrmY9/6UibMHify3tUjdISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQrGSZIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=St9lrNg2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQrGSZIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="St9lrNg2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKQN72916795
	for <linux-mmc@vger.kernel.org>; Fri, 9 Oct 2026 13:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YxvPGKyNsWBvKdzUe72SpCUeaMvMNqz45LO
	5vcpm6OM=; b=AQrGSZIY8fgj1YLMFt+mSyQWJOJtjLQ4L4SYpU0qY2gb4UAbkHY
	XgLc6WsH5un/s5Y1vd6UcabQMVXpqpF9IC35UdNGCOcVpbprVu667yTZ5Za9i+x/
	ZHdM0GEzTjOYaONVhA4G9IWNsQOqr5hlGDx+n4awbUBWUrUnVPJxxUSV/7Pjxftw
	QryaRc6aPkBJuLlgMMfcSQGh6fwPFx8KF2w7YC9S17aZ+0ilB6TY46OVU9puFYWI
	TJxZSGne84IEfJLtn1m/wnagjRw44ulWmsekNR8FkE65dSdadkj34nxpMgVUls7u
	Dnybk8bRTUf1GrqkkGiGyCDRK3ya8zw5Bww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nuftkvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2026 13:49:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ae8e7e546so1294535985a.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2026 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791553786; x=1792158586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxvPGKyNsWBvKdzUe72SpCUeaMvMNqz45LO5vcpm6OM=;
        b=St9lrNg2xCNlkRDQLvGy9m4P35wtBCti4ia75k5zlcE3qefCApxOkTeKKPZs9hjb6B
         aIA7vCRklDFISudSF9YGLLQPUUrY7IA4lhKKciNFwQi/NsR0czegNmXiVhRODoPjVTNP
         uVA28s2kKHdq9AbSorYbK4zuIcJKaBsIFccsyrYbDn+/1BCCGubpaNtpMME5irKJlqbl
         HrGBBs9mRhgSDAZyImFDjktgFMrYJQZ7oXEmxzNvYMlbqSm79+p3ZQj0DG9yxHTkOTim
         ZGNyTInecIYEQ7Utm7o1CeY3d0rP/76cH2sA8QNRa72D0i/82g5YIDnkKVwQwAu5i/Lb
         vLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553786; x=1792158586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxvPGKyNsWBvKdzUe72SpCUeaMvMNqz45LO5vcpm6OM=;
        b=jmI3ZElUp+2Ruj0LZ5QaCB4Lh43VS4tnbMbZ5582AZZSTV5ikMg/hAc6TKteTgPZcK
         MTUwGHTsNVAtuZqdQPPSoVQcOSFEDsbGCYj6b5VfxRxXxot1GBdSoaL1Br8xHZsFZsqg
         SEsxxZXRN4j/sGfVpKG6lI99uGNym2LmghhWQIrANJmkFc+ylGsC1kbxFdykJpiaoBye
         8LFp0+k1Ot6ICqY1ntr6AIfVV/mJzCEfmCcSWl9FBCOV2Vr8GO22BcXOQ9w18KJy2hkW
         yr+UrpIKbmJ2oFi6nbYC3GpuAqf39WCMz5WWXM85V9NcVIUScRJ/Sx/rFlFA6E1gtz8f
         2F6g==
X-Forwarded-Encrypted: i=1; AKwUvBz7Uo1hM9j47+roFX94xoxPXhOvorsJLVzx600MbEKaeQKwl2g7J2Zghpp8V3PMbvNvqzOoWxEVcVo=@vger.kernel.org
X-Gm-Message-State: AFuF++lcEYCPzRxPyNEKQnYN0q7xtrwC8xVLno82EuKcXpCNtzxIFO3G
	R5ofaQvYv5GA2qdAMXcztg2AdstyafGa6RMkWy28H6g8GE+X79HV0mzPTj7io2PplLmmY79H8FS
	EC5LeMpUUdqUmefEcyW2efWT0BwlMCaran+whIKNdRfelsmOpAK6gD5/WFw/h30E=
X-Gm-Gg: AYBFou37vnt9vE8Id4av3i4sS8onQ/XhNtY04ZGj4Yf4/1OJtM65ggJt6c1fEfBOaqU
	LvU+gg7pQ8W0NYxNCuJ1MWRzaEGcMhe+znqTwQ3ISDRvNLeZSfsS7P7s3Cswe7bGZ86SPn2tyw/
	ZDKo0yu2j3YU1j0csWo3laJINc1bQfU3rpobKNQzKjXai2h3xME/Ue+wMyiQKel1KZtd9Vctfqd
	1tcPHDMbqyqDtiahahQ0EUCL3x4HNGJy3vtZj8M7c57cC1wW9yvZLF/AVP4dOxPtQRk3iVJlbUx
	I6VPLc+/ZizAfwNn6IqL3TwCol9s3AQUo0kNNmQscWHlhcmToyAtwqSckna7pMMsqF3lE1LWzm7
	jYwbjzuJ+1BJbRHDdgp0AwMnrcBvj9i3NedtELbpLSdI9kdgxZ6OaQio+LA==
X-Received: by 2002:a05:620a:444c:b0:93e:6618:f4af with SMTP id af79cd13be357-93ebd28d68dmr292142385a.63.1791553780927;
        Fri, 09 Oct 2026 06:49:40 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:93e:6618:f4af with SMTP id af79cd13be357-93ebd28d68dmr292118685a.63.1791553778471;
        Fri, 09 Oct 2026 06:49:38 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31cf19ec1csm47127566b.23.2026.10.09.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:49:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v7.3-rc7
Date: Fri,  9 Oct 2026 15:49:35 +0200
Message-ID: <20261009134935.20982-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8f0fb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=NEX6-byUaBDHWsRagW4A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfXyOtOCPRRNWop
 lvPh06SP0a0cJphKVWM3HoMXBwy2EpAKBadpGLgC4EMm9ChHKSfknDPNuWJW1aEEmwtG9t0DLj+
 lFxkH0o+jP6Fsn+TjPDUEW3OuC4CATA=
X-Proofpoint-GUID: leJW2s2FVv_hpNs_JFb3NjgkfjuVlSUw
X-Proofpoint-ORIG-GUID: leJW2s2FVv_hpNs_JFb3NjgkfjuVlSUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfXyks7uM834Cm8
 ZA/WAUtvBJhG4hTt8q4s8guvuRJPO/7ATj6jNUaUuWTULoSuRN86FBJjH6sYjwCnigexpaCpdvf
 rk45GVQNflu971oCnnzf+2UAX2up/dIMgeLSivn79OCrFQct0ewe1ion30uwq+1X5lsRznONhpC
 8MfygNovtHSYsHqnT2aATakl68AQ9APrFWM3N/IIWjXubtCnAfbQWGZP6FGSmAnvbinN7fFJS87
 UIoSpHbzgKOiDDTfkUJFrFVezxb+sUBXfytlIUkbpXyBHaYoe9W8k+a6wqWI/ihqkWQQadSjX+r
 b4jnxVaRLG3fHODbKxji/lXiyxNsmO/YC/zBF/LzEd7R4M+yseASvsCOXR56Q/85ITQKHXWlBTp
 GK7ROq65hlqfZ8aKcz6dYo/g7HQeklnwBqOzyGIHXt5x8nAdKwB25OmDEpv7B/QDirxMlVmOoCv
 v+b9S26Jcr2j10twBqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090055

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.3-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4396d70bb7fec531bcf934fed016b2f3300c670b:

  mmc: sdhci-of-aspeed: Remove children before releasing SDC resources (2026-09-14 12:04:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1-2

for you to fetch changes up to c96ca94425b076dc398d929366e378d1e22ec794:

  memstick: rtsx_usb_ms: complete requests after eject instead of dropping them (2026-09-30 17:53:31 +0200)

----------------------------------------------------------------
MMC host:
 - cavium-octeon|thunderx: Destroy slot platform devices on remove
 - mtk-sd: Cancel request timeout work on remove
 - sdhci-sprd: Disable runtime PM on remove

MEMSTICK:
 - Wait for request completion before freeing card
 - rtsx_usb_ms: Complete requests after eject instead of dropping them

----------------------------------------------------------------
Guangshuo Li (3):
      mmc: sdhci-sprd: disable runtime PM on remove
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove

Nguyen Ngoc Thang (1):
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Yibo Tan (1):
      mmc: mtk-sd: Cancel request timeout work on remove

 drivers/memstick/core/memstick.c    |  8 ++------
 drivers/memstick/host/rtsx_usb_ms.c | 31 +++++++++++--------------------
 drivers/mmc/host/cavium-octeon.c    |  5 ++++-
 drivers/mmc/host/cavium-thunderx.c  |  5 ++++-
 drivers/mmc/host/mtk-sd.c           |  1 +
 drivers/mmc/host/sdhci-sprd.c       |  4 ++++
 6 files changed, 26 insertions(+), 28 deletions(-)
