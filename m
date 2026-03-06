Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B28FC
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755461; cv=pass; b=mkuwrX5wUWdL9Rl11Xmpikx99emt/AdyRYwmCRi/stF1vxI/jJoBAYjAT/SWhMXRM5EdZNAp6oaMhlsocIT5Ts753q5DSxhjUfnIgW1YJk9LCcco19X0haqlrAablBHit2DRsPEpyh3xahIiIY/i85Jj8xZamKC4qb4zchHFYLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755461; c=relaxed/simple;
	bh=KBvvf8N2RaGPIozECyx0840GlcTC3+viR+5yLyf4VBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1YMPe7U2hBsKzsAPfPuW3XuVl+ARKbzZpXJB4yJ5hzVDuIF9aa0JMR3MCzHHMwDA4jVlx6Hu5DNEtgQ1rMvQPfHZKTE4O9KfthxExqwiZ8Vy1cGGT2JwKuGgLWzJPzgA8DhLHVjSo167AalrhwYJ4RroiddnRHFdwpfb4O0bBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e6n1Naer; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6n1Naer"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae4e538abdso47578615ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 16:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772755458; x=1773360258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGgPHOb9LNA4VG/YgEowkZtw+HgVZ/AlxApbKya7fb4=;
        b=mgklQnCtFo1NH/OxQMwwCZ/3t8metMZEN6iygMQZfWb4b6YtKt9VmkMPVdvhpum/cK
         RtkMolcP8fVu3pcGxoYmFK1POeRmTzw3CaQvuOm8HE6K5Xo07rnPNtRupbx1J4kyzUyN
         kXvsxAm3Qn9JpdiJeKfSBt+B30CjVbN/8PWtQYEmAZe+g5q87xvfm8F5KxGuzEunz1YD
         lx+0stOa03w5pTzLsOvBU5biQsi3pLSVi3dk4960z6pEDApiRA8TUNWl7iDJCHZGACAX
         Ocd6VOd9W/GO6BvOcnLxkxKfGKYd9/Benv6gBSJTo5II/RMLZZKpShESr1sQGRgKoa6U
         lBOw==
X-Forwarded-Encrypted: i=2; AJvYcCVt6ttGNk5elUjwrvB1gGM1/39Gj4f0zQtY098iWriXX2jurEvqFFwezmBp5KF2KHS0lBeDSdQE7OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFChwlN3i9S5uxfpjryOQw9Fqt1t5xl6aImsEkUtqDwzTU7jl7
	UEDkSpFRGKmnXVAyFHSCO0hGh6Ktbbg2H8FX3s6yYpYkYzZe+Ie5mofd2dpwxqgkOZM3fUvpY9s
	i98PuuFOBDoMoB4Rpee+grRu4+G5yu169ayzctbiC2kjOhKTNRkDPXSTAuTvLrw+Y9mS3PO0Kry
	hDRFQ379bviK9lLgfQDNsWUxd6NPdkY+FrQ3rYawCP+wJg9+GeavCiNn9YmiW80v24HNR5yb2Hq
	JisHZuu+7s=
X-Gm-Gg: ATEYQzz4r6JguMAp3Q+fyvsBCedd/FL1wfP5MyslH9OVTa4TTzykHWPQjaZXGy9n/OI
	Ka8LggV+Pi/KeABa0tpBm8XucD1tuxnSOzn9sMX1vROgnMrcSv6aiKc1Gk7nTHoZRyka+yGk0y9
	leIr7Vh2YaS/JwTN/s7hpdXYgPIS2LTbJfbbHdGvyYJR95rqIDeW0lwARqk2aZy9Fdap2BQ6Z/G
	S15MugK1aGathOMCYt33F34gEPNOrq3xPof1Bs61GQRXb22amGh0+vxkUNm1Moy/SY/jvUvvawe
	Tmtz+5DTgSjCtSY1s48MyuIiCDFZpuxcNinf7lsVzeJpTDZ9ICluKuRGO3/XPwhLrrYg2vRtuqC
	yJGXZF/Q5I0XRsztEeaOeklpElCvLOiApDnHGJxptt7JYQYgzGr4D3nTdOL6AESy4LIFf7/7lN5
	+SMToBid/9XRFaVkSwgfNZskOh/9nz7XvsAcnc/DQMS9DKvgofPQ==
X-Received: by 2002:a17:902:dac7:b0:2ae:47c9:68b9 with SMTP id d9443c01a7336-2ae8247fa09mr3180385ad.49.1772755457831;
        Thu, 05 Mar 2026 16:04:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae3b4fee0esm22806855ad.35.2026.03.05.16.04.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 16:04:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899ef673d82so102575096d6.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 16:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772755456; cv=none;
        d=google.com; s=arc-20240605;
        b=PF5lQKObporikxXM5iUjqzlvLxly/WdgQHJ/rnBHADSLHn/ftr8qXj9dmE8veo2eVJ
         3rAlLfEdKHGNFqw8PRHQiwsyhh7Ponj8t0pwxCTqMRkHJ23dJKM+jpJ8gc+xTwfAzaeE
         sRZLAIEj8yspWEt/RLzOwS89x3dv02rJVELclywyojnt/5jBWeXy2FjepuDMbuc+mat8
         d0Ci5x+/lObzdvb78ferdn8FM5kVUeuZqWWTVry2wITjKthQalHFQgS/g1fTh2h0Hx0P
         PbXDECO12DylTGkUGWxZl3hQpoybwYvRXakzp4E7rR2DPQtBbUP55KzZ3HD/Kb496Rwt
         dZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HGgPHOb9LNA4VG/YgEowkZtw+HgVZ/AlxApbKya7fb4=;
        fh=rmeZuu8I3WlOsgDDj0nmifm+AAjaRSJZ8rLM9kvfIVI=;
        b=RcgK3gzeqY2XVfp0obnhIHWCW78M6jEDFF+ECuM5LSakuKMX7zqDxjPIMno39wzl/g
         FbJ3C80cpw9KWIysamfC6QcnNSO9VYhjkaody0R9taC20MfWIugayF+FfGgrDkw1YWOL
         pqRywEG7lROqRcZ5kHuxT+QmkorBpqxV6P2eWVnzwA5f4Kda0qd61mIJdNsZixe8mDC1
         u/PSN4uiV0+2Z6suSEyKS0DjTWQcJvb5qoN2ntdHwnLW3jVkJ+MKKSO3gSFZ318/7yvE
         VMr2kQgDESDDWzXuXdSx5apmFK1oWxtFidLSvvKwvETsKIQW9/ziuMDZ6n11XkhVYKCW
         v/EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772755456; x=1773360256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGgPHOb9LNA4VG/YgEowkZtw+HgVZ/AlxApbKya7fb4=;
        b=e6n1Naer7MnK8ZjF5jMubuyxcZZegiX6XiSvgnokOEkQ9m7OyTWqCyH7gzjlWUAV34
         AAr8Lw9LgQCVljTYTwngR0osq5UM5auKfrqQ2cF7YZNiwfJkX8er4KxbNMWxRled3bJv
         Mjf1o1KS91K4dW6pZ+Fso6Nn1NF41WG1A6FeM=
X-Forwarded-Encrypted: i=1; AJvYcCX5bLLVTC4Z5hr1y+Ujg5/tmBopyXVrZNfeeYHMYB0yoiqxuzK2M+qtqH2WkF9B5hxEvcS+EpOOPdU=@vger.kernel.org
X-Received: by 2002:ad4:5c63:0:b0:89a:b94:3cb6 with SMTP id 6a1803df08f44-89a30a185cfmr1581646d6.1.1772755456453;
        Thu, 05 Mar 2026 16:04:16 -0800 (PST)
X-Received: by 2002:ad4:5c63:0:b0:89a:b94:3cb6 with SMTP id
 6a1803df08f44-89a30a185cfmr1581156d6.1.1772755455930; Thu, 05 Mar 2026
 16:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305234703.38490-1-jun85566@gmail.com>
In-Reply-To: <20260305234703.38490-1-jun85566@gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Date: Thu, 5 Mar 2026 16:03:48 -0800
X-Gm-Features: AaiRm52ajbNA-KOCPAQu8ZtWB6nH_liyBi5cNhmnBuWYo6YeJEH4v-Lsfkk0GrE
Message-ID: <CAJ8Y1dTJ5yNPP8BN46BfDdLAvuWxW+OrZ+P538Bp9+3_6XankA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent property
To: Lee Yongjun <jun85566@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000488901064c4fcb67"

--000000000000488901064c4fcb67
Content-Type: multipart/alternative; boundary="0000000000003991d0064c4fcbef"

--0000000000003991d0064c4fcbef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:47=E2=80=AFPM Lee Yongjun <jun85566@gmail.com> wro=
te:

> The Broadcom iProc SDHCI controller supports DMA, but its binding
> schema does not allow the 'dma-coherent' property.
>
> As a result, dtbs_check reports the following validation errors
> on the Northstar2 SoC:
>
>   mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>   are not allowed ('dma-coherent' was unexpected)
>   mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>   are not allowed ('dma-coherent' was unexpected)
>
> Allow the 'dma-coherent' property in the schema to fix the validation
> errors and accurately reflect the hardware capability.
>
> Signed-off-by: Lee Yongjun <jun85566@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> index 2f63f2cdeb71..579e44843404 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> @@ -38,6 +38,8 @@ properties:
>      type: boolean
>      description: Specifies that controller should use auto CMD12
>
> +  dma-coherent: true
> +
>

Yeah for Broadcom iProc SDHCI on ARM64 platforms (including NS2), cache
coherent DMA is supported (as opposed to other 32-bit based ARM platforms).

Change looks good to me. Thanks!


>  required:
>    - compatible
>    - reg
> --
> 2.34.1
>
>

--0000000000003991d0064c4fcbef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 5, =
2026 at 3:47=E2=80=AFPM Lee Yongjun &lt;<a href=3D"mailto:jun85566@gmail.co=
m">jun85566@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">The Broadcom iProc SDHCI controller supports DMA, but =
its binding<br>
schema does not allow the &#39;dma-coherent&#39; property.<br>
<br>
As a result, dtbs_check reports the following validation errors<br>
on the Northstar2 SoC:<br>
<br>
=C2=A0 mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties<br>
=C2=A0 are not allowed (&#39;dma-coherent&#39; was unexpected)<br>
=C2=A0 mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties<br>
=C2=A0 are not allowed (&#39;dma-coherent&#39; was unexpected)<br>
<br>
Allow the &#39;dma-coherent&#39; property in the schema to fix the validati=
on<br>
errors and accurately reflect the hardware capability.<br>
<br>
Signed-off-by: Lee Yongjun &lt;<a href=3D"mailto:jun85566@gmail.com" target=
=3D"_blank">jun85566@gmail.com</a>&gt;<br>
---<br>
=C2=A0Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 2 ++<br=
>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/=
Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml<br>
index 2f63f2cdeb71..579e44843404 100644<br>
--- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml<br>
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml<br>
@@ -38,6 +38,8 @@ properties:<br>
=C2=A0 =C2=A0 =C2=A0type: boolean<br>
=C2=A0 =C2=A0 =C2=A0description: Specifies that controller should use auto =
CMD12<br>
<br>
+=C2=A0 dma-coherent: true<br>
+<br></blockquote><div><br></div><div>Yeah for Broadcom iProc SDHCI on ARM6=
4 platforms (including NS2), cache coherent DMA is supported (as opposed to=
 other 32-bit based ARM platforms).</div><div><br></div><div>Change looks g=
ood to me. Thanks!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
=C2=A0required:<br>
=C2=A0 =C2=A0- compatible<br>
=C2=A0 =C2=A0- reg<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000003991d0064c4fcbef--

--000000000000488901064c4fcb67
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Kea1UXiDNimY9XcISXAUrVauS3TPqfSofCP4tOVkOfR2zFsciCJ7DPbmanfMXAR2cY6kCgkZCqxY
9Szy6beT2XZUSE9/jFymRSjXZNnLqAe30YCaVeVQUqW9X3NqlPdzO9Ce8AqKdgBlVt4isO6s3zJ5
djaWSUM3zrweXgaVpSRF3iBUxK45Nb0qOkvz0hrBYM2r+iLWR2YbF+Z7W7lw2QMvkbeT1gXn+4pC
K8f1aWKsB9e6Id7uBOkCAwEAAaOCAdgwggHUMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUD
AzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
b2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwHwYDVR0RBBgwFoEUcmF5Lmp1aUBi
cm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt
26AjhRiwoJIwHQYDVR0OBBYEFLfOZFpVhKW7s+LOyKdJX5PQH0f8MA0GCSqGSIb3DQEBCwUAA4IC
AQB5Y3tHNG503cqE6g1lZJG3Z1SbuQD8ZXUbYqDNZCnUAd/+zUCraK7TYIOI83X+oof/CscTxVhf
5mazzhESPjHYlC3TLkkxDHQZi06GwKbI00651REpC78vd9dOdZnKnGjpFeDiwJKNxdarSaYiZi/t
6cZD3FIvDaJwYIQ+8HvZOm7FBicC41sMoaxGWZ/tdC6yRoLFckWRvhq0e7wyaBOH2ae8l30V6NXB
RtJd4XemoNk74ybCcGMro0zyBCzQhREo2slK5r/uflroC607XCCIGjLuB6TptSxV97L/9/QSrE2U
4JteFGVwRBJw1s7k8ICf4s22debUZ+OlB0mXjI+8EUDt6vdMeregn5ilQQSsDmBMnz2GzHfV30tb
X92uoE5xui1g4Q3BWkUVwd9wVHaganr3rzc+lQDnQq5cddu1supu3SWp5FqKq36rtf3RX/3zHZ0C
P2pCAlilDHYH2NRF8CYb+gqFySS/PUxwPmFWuD897Hewokex+ux0oZscsuRe0IttCbYfjl/+tSA0
a6Rd+AmkiyASFgEHsLGl6q2OTPYU1PikjUe5RXTp0UC7bdPQXzxaORlh/KWilnz/kV2XblDdybuc
Qz3eVIGvTANnIqPpz94oImrgHX48hMGiH5gGNznLwDBoQl4ZSfvlSi01TcUsYlHJD3LRZWbsh4VG
PDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDCsjlIbQJoxUU3h/cTAN
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg83t8nghsDRXm6WNXY8jT+IAj9FVoyhiP
yORclypNC20wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzA2
MDAwNDE2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEAQ+lHJAp0oiBXnKkmYLql8ffF1P0/T9A6hIhzYO8659KTHJnt7xcanBp2/GmxxNr3V3aL
mOB+tLZfac1rEqxe5h4OoVMZC/AijefztsaZhBiB8MlqXT+NSg4al5Pd6fTuMV+XGHEZeuNPfy/6
ESFZQhF2JiCYSBJN43sFt/nJEl6mdYVNBDcb2NKp4VtK8zq92kcFuZ5BNd0KzntSOAhyWRCUfeNI
iGYqvPT/ScyiQLtZ/76uVq9kFMia4TjdvXsoFwgV+BGpKxnJFxhNYcUM3gvX62LYijpOP2bwe4fE
fZ225iFmEhmNigVmXT9pC21mAy1sPU6FPVhfFBy+1l5h6w==
--000000000000488901064c4fcb67--
