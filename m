Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368826;
	b=Ak+0NN/2qMjUHvBlh31zOcigJ2WfTu4bLR6SBTRMcAfCtJHLpof78PYvZemdtpLTkUv2
	 5KD+5w/l4nxDlyOULK+pNoaySCEl7Gw5eEaUi1TQQHfg3KdZFQT2jbVMmtMNz31BdzXX8
	 faNJq5jZcgfLqdaTVWGy7InAMLPvE6g+tWk0gz0KSrvgWzCmNRtPwaKFAzntuJviAptyd
	 ceDkChE168EIzqYxX8QXnRTbtnLscRcRn5eAA+X5pKTbH70HtObpHFXF7Xwma2zfsGyZ6
	 /0N3jOU3T8rxGbLKrUVDBzeG/MaT7aoUov6z8HkBm5b+/3f6ObmX9SHXK2qdLOhqGUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368826;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4VlQE/YYM104mVCz3Alg3Tfd4LRV98KYdYooP6VbpO0=;
	b=qpWg36oBiMgrJPrSsxd5Kjz5KNA5o61y+NTL7Y7LKTwCd9m/rZAFGwaIgWtjwC4vVJKp
	 qoAaAkFb9hPIvsS1dMrghRmZugEpGnAary6IPq7dmQZg/BZAjz44plaXN2NgD5Kj5fPTE
	 ZuVFaKQCz8/PVIuPnnhacgLH5rRZDfAsLGPe/1Mc26+TU2HzRcSVQNlO7rhmAWBEb+LcL
	 Aj+pcZN9JbqCCuGJjc9yOoeRSky+RsP1jbdA8DecDfOofNkLSkI/XAot3tGWyNV2zsf7a
	 qxjoQ4EvXrHQtxC9SxiOExisZg9oegZwpTFEalMQivnIKT+LsL6tqDOjPNe0dW/tcnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DoOjte4O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="VRgAR/W9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980D606A327
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9980D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DoOjte4O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VRgAR/W9
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDnAFD263333
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4VlQE/YYM104mVCz3Alg3Tfd4LRV98KYdYooP6VbpO0=; b=DoOjte4Oh2y3nnAu
	iO3a45AMuu/BW/C6VaK1G13K48ZoINrjmtGsOjI+ajmSuZqrjzt3cHOIdvSnVLKB
	QqWg/g9f87E5UHLCaPlgeBTvlasOtpD0KfeeevxFHCa7tf2gjo5RGrWCJDszgZZG
	WLxN0+aHN1fuBF/zyqQU8YESrVw+N/zY5OzkU/6BJ976cFXNQHnvIUs2R1YKGfAI
	4+wh10A8ndE1vM3nm4fSFkmhbvt1rqCYyCsD855dWN5RmFfrXnF+vSDhJTbCc9H/
	mzjAKuIk/FuRLI3vWgVDiABuRxHbYjwrgrshklGenps/XdwT2qCNInV0Dt9MeY92
	4uIYCg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rkf6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd66551e02cso759877a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368824; cv=none;
        d=google.com; s=arc-20260327;
        b=jm7vF90Xz1KpXpr8jRH2HO2ChN9U4AMOVIUUCjGllQZ3DeeO/M0wWDSa2NgxC6UARE
         B3tftlNtRf+mXLHxoh57KHJ+gDI0vudZkPgraqEutSLyD5Vgnz9pwK/WzWUd6gfFrmQ/
         3JZzvRKufEQAGJXKfiv4M2vyX4se+SBeWUdq0YJfsdM/vG9ikiApMV9jLn46ziPIq/Nw
         Y1g9BwWmSMO1/WAINTL90kAbYTovG46g9yCZkQf54/hnZy8+z6n0uMm1NAK094NM/UMY
         TLT1tMr3Nk/YF+MQrSQqcNK4YlcBsrVcXH40On0FJijpCq9YDr1WXKjoMAKSE98W9Vuy
         uKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4VlQE/YYM104mVCz3Alg3Tfd4LRV98KYdYooP6VbpO0=;
        fh=2BDAeg89D3YRyYj1rapQxPg+BypMzZwPTB2hZnRXRyQ=;
        b=rpIs4QkJ7+XE4Mdf5z7IjtOOY8qTTZi58z6s7N26f04wW2iw3GNt8SsPFmgP8nCbvM
         1kAGVLTZBiV6igrhmEmQ0SaQp//vd7MJhjel4yOstfsBB02ZA7jJMQxhyl3q32qCBb4k
         0IvpcxW7CWM6gUQ6wSH/ymKO6pw4x+3LlA9W61c2A3t/rVIwtRuogtgXwuLDl0BcLE2q
         c3w9pw35rr4acy6iKRCEWGu5bBOxbh+38SwNTGiBzY2kBwbWqp3iC+esHj0ZHp3/wgu0
         UYKIAT6tyKlPOAaZcwUKMTZMtDV4iPwQsA4daZyu5wu1ajN0wlhF3WqivoyMu7pNzfrM
         cSLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793368824; x=1793973624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4VlQE/YYM104mVCz3Alg3Tfd4LRV98KYdYooP6VbpO0=;
        b=VRgAR/W9hGMManKl8/hD5zch4Lj/a2311C4yfU3MMiwy+Wc0Dzw1L7rbfRlBOa7aW7
         VaypeAHoPhYnoEQvSSK46yibQMxOJaiVE3LgkdrDZf6+eSp9+hem6sowQliUCOE8AGrk
         qlNQ4MhA3XEZn7Gmd8bv4rOIMeQdb8CfN6Qgc6YGaEpH8c4qKpU+sPlxDWU3ptwZEM3W
         PdlZjrC9LMXxDQDG1/HluI10hkkstT9xMhtoLm4NE5iwYmx+SbPNglAz4N67Tvq0iFEZ
         Zc6LTjRf3egCsPvXORUXENZWbeMg+en7D5fnOxGeW39xAuG1wB2Vwx6vHnbBMktxi7P6
         OFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368824; x=1793973624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4VlQE/YYM104mVCz3Alg3Tfd4LRV98KYdYooP6VbpO0=;
        b=KFHfFGkBR+qllCcYlHNgJDnnp/dsZ36CZMwmPwSqgEqcWsWCPBsOtk6QdUXOOYJvlT
         CgNzoSdpMSLyeP43+J0GlDO1v923uyu5Xqg9j4rgYCemUidv1sK8hYLh2Wdr3egD3UTK
         fpuoEU9MJh/xWNXttKJMB4VcWLQAGPjUFe5PKuZJ+p3hIlxuTkZlFA/SlOn6dICUkydm
         Gxd+Jtjn1PH0UCuTX9GUi3XyouCO4kdG2Tlv6bErwCLpIuark+/h7M5i0C85XCAhuK0J
         JiZzEBMH59vrdN+DxunebgTmVBSmHW7PQ6IO4+mvTx8v74bcPSJ16PnJg6Zp/mW4fTR9
         ZTHQ==
X-Gm-Message-State: AFq9FYKux2rr9EkXCNMd9WcpV7NOiaOmjVBMJwQt+HiHZK93GE/hJMVf
	PWSXO2lLSq7cG3v7f+exNtdZcpDrnBbSmubgWpH+GIkBw/WGlopYVjnYYUGHPvGzamUx1xkcNwt
	oGu4WMZgLhGSdISvr8cFe9XBXAgrAiueS3fD/3xCZhSjefBkL721BdrJz2imEDevpD/DhwgOZM6
	a2yPa8TEbLRiAEm6HErPrFv1UYnESygeTeI1I8BCxhA8nrWQ==
X-Gm-Gg: AYBFou0QSza/uAIpoEKGG67dIBGldNKsoRaFS7kh8eLQgfITM18aQQJZZ6y05CAB2IN
	pxUUeitF7MFjSwHUQN/7Fd9KdAW+A5DyyQtWrYsSYE+ciSvBZ8K7xdddueqqJeOvXHVmjGe9ouU
	Q4748MZds+PyRY72DbA+N+to234si97J/hRATY9MrS2m0VZLg3LCP6VpM6Bg==
X-Received: by 2002:a05:6a20:244e:b0:3e2:3c7:7754 with SMTP id adf61e73a8af0-3e928a7e407mr2600779637.65.1793368823833;
        Fri, 30 Oct 2026 07:00:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:244e:b0:3e2:3c7:7754 with SMTP id
 adf61e73a8af0-3e928a7e407mr2600707637.65.1793368823033; Fri, 30 Oct 2026
 07:00:23 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261008-do-io-unsigned-counter-v1-1-744fa81f0a0a@canonical.com>
In-Reply-To: <20261008-do-io-unsigned-counter-v1-1-744fa81f0a0a@canonical.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:00:11 +0100
X-Gm-Features: AclHuK8fAEUMl-isKxxK8xIIk6oC9sIpl5AFM_8tQr8lBITxVJVMfetP17h9RRE
Message-ID: <CAPx+jO9K+tE1_A9J0+M8RPNOpGF0wkQ_EOCgzAM_-UQL9dJS7Q@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Use an unsigned byte counter in DO_IO()
To: sebastien.bacher@canonical.com
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org,
        Sebastien Bacher <seb128@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0DDj-hOcEXcBGZ0465usphVqUhU9L1nN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfXy5co7JhKqBrC
 9EoNCkfNRJeDDRONySex+NzE4s/KZH6MCV+HaTthnCZsvZ+L5Itvo5r+PTF+QgfozCkbuiOtrCw
 211pU0Rfg171IPYvbGN4xZa9iOjNCxU=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae4a2f8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=fxJcL_dCAAAA:8 a=DfNHnWVPAAAA:8
 a=rrAZ_aJRX1qqUfewUWIA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX1hzBzu5in/l2
 QmkQN35Wf2zw4OtCJRAAHRmFQpi5F7PiEh2pUSPMMgz67G6iKhTergFyUCqUnr5n2NAt2Z5XYQr
 qd/DZ0mw9GpXT2rnOvaBUzWXeE8GH0mYBWVRj7BrY1Z3I2yXzXkBJiPz3GPG9mQjQfBOTsKNXZw
 ypJubvrH7hHYWfnn9lHWDf5JkJkVIj2Kt3i8iEQCNZxFQVHNEcFoCjGGwHuSxHNwjuZKOviO3V9
 zKtwlZJj6JSLWmXWzPA40awaq5hr9N/CsW67rcW7G6In6Ap3i/Q7iGjDDjgbllx1Eq5aj/GYfCb
 irfjUvD1dpCRXam+mnHwOW9/B6mH9BdNZBoABBc6g0Toi4lURkwt5xd2uW7LKnYFsizs90z0R8Y
 enatsEnuWScENrQPKDRtGSr+kqSFuie510y3wkPbcFgHQj1PmvyFtv/+jZgpI3y+dJH56qgfbkW
 8+IIPVBofS87R+ZRxIQ==
X-Proofpoint-GUID: 0DDj-hOcEXcBGZ0465usphVqUhU9L1nN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300054

On Thu, Oct 8, 2026 at 11:02=E2=80=AFPM Sebastien Bacher via B4 Relay
<devnull+sebastien.bacher.canonical.com@kernel.org> wrote:
>
> From: Sebastien Bacher <seb128@ubuntu.com>
>
> DO_IO() tracks the number of bytes already transferred in a signed
> ssize_t, which is also used to report errors. When building with
> _FORTIFY_SOURCE=3D3 and LTO, gcc 15 can't prove that "nbyte - ret" stays
> within the destination buffer, and the build fails on the RPMB data read
> in do_rpmb_write_block():
>
>   In function 'read',
>       inlined from 'do_rpmb_write_block' at mmc_cmds.c:...
>   bits/unistd.h:32:10: error: '__read_alias' writing 484 or more bytes
>   into a region of size 256 overflows the destination
>   [-Werror=3Dstringop-overflow=3D]
>
> The loop can't actually overflow, so this is a false positive. Track the
> progress with a size_t, which can't go negative inside the loop, and only
> convert to the ssize_t return value at the end. The behaviour is
> unchanged: EINTR is retried, other errors return -1, and EOF returns the
> short count.
>
> This is the default hardening configuration on Ubuntu, so mmc-utils
> currently fails to build there.
>
> Signed-off-by: Sebastien Bacher <seb128@ubuntu.com>

Applied for master to mmc-utils, thanks!

Kind regards
Uffe

> ---
> Signed-off-by: Sebastien Bacher <sebastien.bacher@canonical.com>
> ---
>  mmc_cmds.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2d9069f..8e21a25 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2207,18 +2207,21 @@ int do_sanitize(int nargs, char **argv)
>
>  #define DO_IO(func, fd, buf, nbyte)                                    \
>         ({                                                               =
                               \
> -               ssize_t ret =3D 0, r;                                    =
                 \
> +               size_t done =3D 0;                                       =
                 \
> +               ssize_t r;                                               =
                       \
>                 do {                                                     =
                       \
> -                       r =3D func(fd, buf + ret, nbyte - ret);   \
> -                       if (r < 0 && errno !=3D EINTR) {                 =
 \
> -                               ret =3D -1;                              =
                         \
> +                       r =3D func(fd, (char *)(buf) + done,             =
 \
> +                                (nbyte) - done);                        =
               \
> +                       if (r < 0) {                                     =
               \
> +                               if (errno =3D=3D EINTR)                  =
                   \
> +                                       continue;                        =
                       \
> +                               done =3D (size_t)-1;                     =
                 \
>                                 break;                                   =
                       \
>                         }                                                =
                               \
> -                       else if (r > 0)                                  =
               \
> -                               ret +=3D r;                              =
                         \
> -               } while (r !=3D 0 && (size_t)ret < nbyte);        \
> +                       done +=3D (size_t)r;                             =
                 \
> +               } while (r !=3D 0 && done < (size_t)(nbyte));     \
>                                                                          =
                               \
> -               ret;                                                     =
                       \
> +               (ssize_t)done;                                           =
               \
>         })
>
>  #define RPMB_MULTI_CMD_MAX_CMDS 3
>
> ---
> base-commit: c6692d5f9bf1ab6fbf5694a0b61477621cc4d016
> change-id: 20261008-do-io-unsigned-counter-568a63baef5c
>
> Best regards,
> --
> Sebastien Bacher <sebastien.bacher@canonical.com>
>
>
