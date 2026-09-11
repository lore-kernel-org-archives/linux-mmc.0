Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF8485CF5
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141609; cv=pass; b=LYkHlLKXBAe5Z/JPONul7FWfrl/CtoKnk4c8Pgswajbmb8yLFx3UXuZqRc1usiGKAIg8KU3IPk827X3F/fkAMwEXrPsIN5njeLdsIFPo9mqByRFrjXVmaHqXzXKQs1QdeKEIn7zFM1wD6cypR4BXmFgobh8Hv4p7nWAoY0rS2uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141609; c=relaxed/simple;
	bh=i2dZDGM5Sr+QxvM5pwbRnREy1v1y2yLtEXCVMfXf8Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa9tbkx3v+zK8XHmuslXTy+/l6ONxJMIwW2MRDoATGGnWrhq+V0MkzHSbe346ilPRXmrpmo0Biu8A1DVlAcLqyoVqjB2hJHQUZHIUoZ4emGcmyDVTUcIw5RYvq9bmhMdfR0ccEyOPeZQE+C6sfEisTP1zJ6gUkN1n5cuBHMUXF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZaSENI5x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxxBdn8b; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZaSENI5x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxxBdn8b"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm0fe1370331
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	52LmfSF/J6JBmW22292igjmnk9P19fKWJ6xtkOPzVsg=; b=ZaSENI5xLcl6rnxS
	k/nC3ESu1xgrpPK6qJIsP0IM/uTdki8F4SjYtLdL/5/nnAY93Q23SRg7gYvPj2rs
	M1xsBcVt7D67/uSdtNKBoUyOfNWv3WA3C9+X7flB1smlUB6zn0KIQqpvY+gbfJHF
	3uY40MkcA8lysBp8xOwo60+BfDD7WSl9w0iYbVqccwTTRLne+UZOAOwam3Uz9/T+
	ebVUAPTdA0JjYWK8LBz1VeAAiR07B7QH1zGx9ZhSeJEthXmnDEfRDzEZS6K3AwuM
	NpYBk8oYEQUkoGMVgbFhbXVa3TJOVaijADIJUSfTSUfZqff96Zk0uuAPCoWU/2g4
	UW5KPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8jjye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:46:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9057fab9eso14855415ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141606; cv=none;
        d=google.com; s=arc-20260327;
        b=AdSQ5PNxcWZdAIscklCkbbweZA7F3Zi3oLqwZCRLgA69j8sI/xq3oqj4mJp08wxX6B
         rlh6xANd7T1ic31VXq1CpJJgu7P6atLkw33BRz1suVjDt/0E2Bov4iV6OA9NygACXz7W
         OqXHiKqLjvP6PNRze9rkLgUK5vkehsGXZ15Rv49MWs5hWM8CuTjxKpUEz96IJkt0aLuX
         5Qpv4BxcAH9Auzhm1rcAMOwBd9BTp7Ojx3KjfE/4E1pi+ke86f+UYWbkFJEPrf3A0Mq1
         ErZ/JeOn8kYesV5AgosxhPpC8hlyc9L1Rn7VGFl8isJL1vVhRdpEidiqDaBzOZ7xYmzG
         jQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52LmfSF/J6JBmW22292igjmnk9P19fKWJ6xtkOPzVsg=;
        fh=11/uxnUbrCAkwPIvw+mitlDDTraevDRq10SNBarKNQc=;
        b=kZwfiTzQoXrXJk+XO8xTBleQyycCiaB6HAvm7+tdpy93rmYhX3jvlXx6IecTkcHzZA
         YQMM8F6AboF6RIHywX4xdpEmeCsE+GIGFhqB/ted5bqikfa7PGvBWCDpCIYgjyxkmmyi
         wt7UwbiZ3U2ICtjNJzjWHa+FiPy/K04N8TI1njHTk3X+2TN90qnLPMH0jTAhPlAV9hqe
         +EPbKGUyqh1eYJhC0H+qUY/4kUGXdOWr5MHWa3+6gmpK7vupUoC+Ko7haJ/dR37dVnlJ
         jo0F5zPJhHC+U/TsRI2E3SW2oRA1Lv2Al+t59Pz9ztP7aRGiJJ+Cg5aIc6xA0Pa/4TXV
         fZNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141606; x=1789746406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=52LmfSF/J6JBmW22292igjmnk9P19fKWJ6xtkOPzVsg=;
        b=NxxBdn8bhVOfbuEmSTjeK8riHbis7U5yydJ8/nUDKfsDFxXZIw/o8U63rzHLswZLDy
         T7rJ8z/GrpdO+uzUAP/KVJGX3bRx00by1pZeOyqhkWvD8eU1UGalHiHTp3ktna6l4ybj
         PBoRltjCr9BGc7BNynQvRaFLrOmOad5O1xg024jEMVKl+c2wmg9BHbte4sFW+47FaiqM
         1vafKKHsx74Z2J70ziNRLhGFJA1ZOmjleR4YsPPIDnCfypkxcZoa1IEMmt4MY3tBUoos
         txVoWXaPj3OaRmsuXoUrWiIkYrwmhzLpbxS0x/Q5C5DAKSJ0KdbyFVNllzdJNkUFh9Ew
         yQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141606; x=1789746406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52LmfSF/J6JBmW22292igjmnk9P19fKWJ6xtkOPzVsg=;
        b=l9Zu67bq5hfB9oq+sK7SEya8jO5GwoxnzDZV5BiH/sZr9LFO5tilLvZbJ+cVE8MHx1
         +0V0O4yc6nWEOva7lvuvrFQh9JIRCXwejlTA8veGgSjn+ziQSLB99baBDd73ThLdl0L2
         tYuLWWzjoCyiA6IqgPRb1wXNuEED2wMyq54NpvGj35uQOI+CGVGO6SfGpYaIFeP6RIJ0
         ZuqH1YnW3lGzfVCk76kjJJ+zHaPt5v3w4vBohugMCDiiB4SAbhPICFwUmddOATehIjO0
         OQ8IDpCK/IigwyTW9ICYiZELeeJvYVsu+UwvX6bJ3nV1V4JjLqaqqzGNeTdSD8L30J8L
         gwZQ==
X-Forwarded-Encrypted: i=1; AKwUvBx49sSf0QMym1mxITVLRIcw07apxfI5PSW1spdaydn3Nlky8JgHDHgu6ar/ygGSbFueBl29FM45FT0=@vger.kernel.org
X-Gm-Message-State: AFuF++mKToL1M++1Jc6wfwyMBVAie+cL8hPzzNHtl4OXIy4huxYmWmcT
	m6IHrItCC7nv8pusnxjcUC8+00J4hLmXBZkeSPiLwMqZ+VVDNKilDrmBybvU8A12FH1xZasNX2q
	twRK5/XwXoXjM89+yqo78coenVwvX0KG2qIYvDEBxOUnnieKa6MUzzrmScFBYuEXd/XjOq7G2Vd
	Sq1yFmSEubrX+9LFZNz3k1sufpd9hJ1y8YIjVPvyzBt6o44dPP
X-Gm-Gg: AYBFou2xxgyjuhWYqjSawSUGcT2eyfnFT9TYdHtxIF1iFcU5bWYo9cwMrHNtVj/bPue
	7C5pq32SfTk7Nn0hG9o1c9+zVVhNYFi4rxuzrX3yuPHBFBXWCiHws7QYuNgvzv1zoRNW5EL23O6
	G/lDCdwss+adeCpJXZ8xHDPOphggWbmca1Ldu87/DmxQNauCzGHFQaOQvmKA==
X-Received: by 2002:a17:903:298d:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2dd2a1c3f97mr94684505ad.4.1789141605764;
        Fri, 11 Sep 2026 08:46:45 -0700 (PDT)
X-Received: by 2002:a17:903:298d:b0:2d9:383a:30f1 with SMTP id
 d9443c01a7336-2dd2a1c3f97mr94684105ad.4.1789141605249; Fri, 11 Sep 2026
 08:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827091436.1339716-1-xiaojie.li2@unisoc.com>
 <CAPx+jO8Lc3iNNBVjBB33aJYUfdr2EJqpL8mS8weKnZcBaDf0vA@mail.gmail.com> <e69a63062a43456097939c622395cc7b@zeshmbx09.spreadtrum.com>
In-Reply-To: <e69a63062a43456097939c622395cc7b@zeshmbx09.spreadtrum.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:46:33 +0200
X-Gm-Features: AcwNN1XpSNpCb6Sqex0tj4LveTilRiuSH1LF9e6Mjhq1EAXcAAGcWBtruMj2r_4
Message-ID: <CAPx+jO9Sw=pTq-925h0S7Urw2moANp=n+aScfwRxV9Dn642g3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Modify the CMD1 transmission interval
To: =?UTF-8?B?5p2O5pmT5rSBIChYaWFvamllIExpLzEzMjMzKQ==?= <xiaojie.li2@unisoc.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6ZmI5paH6LaFIChXZW5jaGFvIENoZW4p?= <Wenchao.Chen@unisoc.com>,
        =?UTF-8?B?5byg5aaC5rOJIChSYWluIFpoYW5nKQ==?= <Rain.Zhang@unisoc.com>,
        =?UTF-8?B?5ZSQ5pyI5p6XIChZdWVsaW4gVGFuZyk=?= <yuelin.tang@unisoc.com>,
        "cixi.geng@linux.dev" <cixi.geng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sVB25XMVFgbWg-htLRixRz7rAXx9kX3C
X-Proofpoint-ORIG-GUID: sVB25XMVFgbWg-htLRixRz7rAXx9kX3C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX8MZA0+TqqfR/
 FCr97OiAFwulrWaEV2ZgyHSe1B9R6riEUH6WRAg6p/QOMXpelVbbvI2JxUvUhGfoQSeQbPu/nx4
 LwzvMLwumD8mgrEgL8LUvz1JZg6zINxkTaFhavk1RxCSpRsSSxaZF57t5AoWjKcwlI+//PeurTU
 WrRY2IswJWtGWc0zPn8nOLXIzjCdFTWaVPQIcKCyvEz5/+n0vN19ZGZw8/m5/Em/fJvfA2L3/js
 Uwb99wJYANBOp+cx9xvOuumPcGqtIdhliNDl8iksbcoTxBC4mSQ2bJ0/WfESYKMWtUEhIpnCJNr
 A6nALIXeMjOWXPNVDGxDRctYGMUI5Zdh2J/lx861pyHBP958x3l75T6Vi/okAWNVnWxivAQy6GB
 N1tVnKid+rA1vI6GtpG4AIyoj1QmQPvSaHzbTGlNz8hbz+lsQrKZNLJO9TSe03qhEp1IXHDVhYh
 5DDQjEH0/o5T7QK9xNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX2F16htHsyWAu
 DR5Ve08GjqvOpvVrRBTE9mpErgUkh8NM6w9TbIaGIynlZJOjXejPPOVsKIcQ1n6dWH+9e4K5qRN
 qELRzjZKgAqy1k1dM8mQMhbFrckh3as=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa42266 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=icsG72s9AAAA:8 a=qdhnC9VRJiNP359Bn14A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=T89tl0cgrjxRNoSN2Dv0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110220

On Fri, Sep 11, 2026 at 4:45=E2=80=AFAM =E6=9D=8E=E6=99=93=E6=B4=81 (Xiaoji=
e Li/13233)
<xiaojie.li2@unisoc.com> wrote:
>
> Hi Uffe:
>         Thank you for your reply.
>         However, I noticed that __mmc_poll_for_busy() and mmc_poll_for_bu=
sy() are invoked either directly or indirectly by many other functions with=
in the MMC driver.
> Modifying them directly could potentially introduce unintended side effec=
ts.
>
>         Would it be acceptable to implement a dedicated function specific=
ally for CMD1? We could create a CMD1-specific variant based on the existin=
g __mmc_poll_for_busy().
> This approach would significantly minimize the potential impact on the re=
st of the codebase.

No, that's the whole point. We don't want open coded polling loops,
it's just a nightmare to maintain. Please try to extend the existing
__mmc_poll_for_busy() instead.

And next time, please don't top post.

[...]

Kind regards
Uffe
