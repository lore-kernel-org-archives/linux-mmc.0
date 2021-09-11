Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1D5C4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DC761242
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Sep 2021 13:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhIKNXU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Sep 2021 09:23:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:35509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237507AbhIKNVO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Sep 2021 09:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631366392;
        bh=l59PM1Fs/cmKt8wqLqgWL72Gp/GHOpUwGSncn3oSEoI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DbfOkvwS3dekgjP8N2b55KrobJfb9Wtz0XuFCJ0wvmVQGokNhYim4sRlDwnHf77LC
         g97myHz+QKVoaoJaTyK2Iy2ng7XFXPWLUmTST16Fxg+UhGRsq5tIeziMfXJpQtHvC4
         +9aHVkh4ntkozBjXWKbzZY4lN3S6sOWpQxWTx81s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MZTqg-1mSwdd49xe-00WTYB; Sat, 11 Sep 2021 15:19:52 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Tom Rix <trix@redhat.com>, linux-hardening@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: jmb38x_ms: Prefer struct_size over open coded arithmetic
Date:   Sat, 11 Sep 2021 15:19:33 +0200
Message-Id: <20210911131933.2089-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c6Ig4Obe3Q3j3moUxcfS+LciEA5uOCXmbpNQ8tM6qr3ju/cJ2W9
 QIOASDqowAyl+AetKcDTc3JOINMJkkUpBM9J1A5SYl5bXG9+P6nIWCtLkl/HY+C3XTvlgtt
 UAzLQI5lfOjt9S/pA4DixRbsIdzZ6zfirD8i7fiRgF/xYmVYhex4k+90eKsfi01mtg37P+F
 uBayeLNE/hFg+D1h50gTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfH7G68vj+E=:8NkfttQKabHCymCsDppJ5q
 LpnweXmrTNuhOjN3P6qEadw0eQNs4XWOvtmEGY5SmbZivKA6KzGAk0hP+4XnM9Mluh8U14hLX
 98/zOEOsZD1OOm3OhkN/mdPeVIn+wqst1TQp0xZ2fa51yHsRqV+lXlnu03TNqnWE9osdPsKmX
 DVeaX5wFt9XhGAyLwvjTIPMCihgK2sIAMnW5WnN5Gl1zZAzziQiNtBEFFv1WWoQU+IhPgxfZg
 C7dJASxOxf8m8MJ99Judu2Iur8p7jRP9Xzm/WWTn97ZiCxjBqN+NHtqsXbXQDhHUCtX1YHSPw
 HL0kHh7PGhlncIlfE9NMDUapRB95T/Tj/Nuv09y5WW5/BvSpZaGYWCf2b1aVmRBbGV3u6SD4h
 I3w8yoThdyxb2OaSWTx//FKid/qkTlD8qv28HlG6th4Q0dTHMx6jf/9bDf44ihcv6WN1Ov/Ae
 HkBlOnDV7X1si9+LIlh7+cNR1RIA8A0R8r70if7jcYdOoSDRc+eNhKNb4uOW0n4Sr8nNgVw6y
 11zSnNt2skpEVANmdGmRhUXrt7aoI8YmvjjArvsY/Gg5v9viHfItVGqvcWauY1GPiUFNC6GIO
 V/F8SQRwXO8MZcaev7ctUdDcOFADBROhT2rr4oUip98M1NIP0NDw0wrQIhDak56JGQiPiffG8
 ZVckQsCbHAH8ksswXYChsCyRNmBzwGptpd5mOh+ZGxUxhakwNrNwoLys+q41Q2n8V/Pu0Z06p
 VGiNvvbyeTRlYCA44luOoDjBCuA/yXuZTtWBkH1/sISu33QkL8cV1lEPM9yvLKngcr2iIKFBN
 lELm+KuV1U2rC2Rhia8fDLzxz6nA53HhozcFCK5ig+N0GSym1Im/d85EO5NRY9m0kXnRnKC0z
 tYg3ZOWa057N99J2EqqfCRFCbYXLbTwLmNSiprov0XeiJBgJ88Exr7IegGKanDKGwqFBrSydN
 U+oFOnVhkNrbbVpLwyAjK6Wzo7FTVzlRo5kfkiG1Qtsxrb8c6p3APxt8gjsnOTld2NSiVhKxg
 zyNhrkFVtOS3lUNTtokFx33ZJzxWoj5yxV0YnECevhuuBlfnJyxLAb/cdlUbXduriT6DMLxEX
 mV+Hty3Ya5mo7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/memstick/host/jmb38x_ms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb=
38x_ms.c
index f9a93b0565e1..a7a0f0caea15 100644
=2D-- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -927,8 +927,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
 		goto err_out_int;
 	}

-	jm =3D kzalloc(sizeof(struct jmb38x_ms)
-		     + cnt * sizeof(struct memstick_host *), GFP_KERNEL);
+	jm =3D kzalloc(struct_size(jm, hosts, cnt), GFP_KERNEL);
 	if (!jm) {
 		rc =3D -ENOMEM;
 		goto err_out_int;
=2D-
2.25.1

