Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130837;
	b=gXxuY8MBMOgPM4shiqDjyH2T+x++1ycIWBLUiLWLm8sgDZ4/+4zwYcyXB1BFUw7KMB6W
	 pmYfivT4pN5kDbZKjiEg2N3FKzHDqwuaTIWQcz4ZJ+U/6rmwesddRnK6U8MuJ4JyYABpf
	 4Jl4t21IHkjdKgGL3DEiWMgPj0+rXdwWfUxKZVhsfCmr+tVZC0h4EihJ4yjVgis9Lxmt8
	 oVIvgyRgcHxkH9RsPLfG35Oj4t4tLROWjR89nQCwnhs7YXv9TEr97TDXubQZUDO2yXiQ+
	 u9D2LZ5JN1AcphdTMLKyl5ScDukgRlSHIUAW/JXCciE4/caASWC0HvUW1V76Z4PVcRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130837;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=tKQwMeScS+PX5JUNa6XWM6x1Yoqw40pYA0rCkxXqaZk=;
	b=0mYqNM89YhfvPSYZHJ/NAp6aWBI7x3y3S4sUCT8xoaPGiNK4PVgssL45RFfxYGGMtspD
	 UP6MXhcuazU3pE6m4ZT1iBm88KrOL+9IJL1VCNyj9G75Fv+g6ghb+TMACqPQossnhA1ob
	 vaFUFvdQ+l3sdukdZQib2um9KgRtmh+r2wkZ9IMJlc3TE56riuvFe77pzOQwo74qqp6ii
	 u3tkYTK7GYhXXhCGo1NvYPD/FK+YvUy2wsX8ymAuOhPIyop59BEWNgT5JFN4infRF1UFi
	 smrd3NYj12QkDydA830OyuHl4H26gMEW+WX/CRTwAWsZHoU87z4toNUPzge9PXLUnDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bZKT1suu;
	arc=none smtp.remote-ip=209.85.217.100
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC9606A31A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04EC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bZKT1suu
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-7c33cc572e6so198157137.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130836; x=1793735636;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tKQwMeScS+PX5JUNa6XWM6x1Yoqw40pYA0rCkxXqaZk=;
        b=Bb74gKw6Eh8KDAh9jsfQFRV68GDNj6NiVSj95LW1uHiwolNjDGBTqyWL8E7Xf+OQZ5
         4NLcMNO2IgdIqMTA2EMdJ1MFAeliorfJRQ7ZGgI9jywqo9+rfBrgkO0TGdsiBsg9VSko
         B+Y2fPKxNMj0sXRN/e9QsVWhVrRfThzbRq939moGryke49G9KRXGFlG4kvjHSStHst9U
         24otFe0DqKc3yNumxSxe9Wq6EcSSt6wbkY7TR3NVDopkHsg/Xhoi//8tNuH3ClFPekD2
         QYs9+3e+Mp2lgy5Y6sA89tjeeFWKyJGLHLEYI4fURl1YXHFEX2K/REvrVEUaLOwAGhVn
         uUZw==
X-Gm-Message-State: AFq9FYI/TBqU9IQAcvDDGty3QVZrGFZaj1Msx6yX4vSNIuskltgmcuRJ
	qOmqy9mSS2+1pQ+Tt1kVU7qlLXNfC48EfbHBhCHc4KZbRz/sGsrviJN7uVSAPBoK3fshr/FEQD9
	TZFRZkCYUlk0BaWC1jaTEF78Xq5IVQw8cWKkq7VKv9wlvRSX23KHMahO39R9VB17spCxPt6iyv3
	jCDoswX+IXC0jWqajjXhpiWaa+XQ6sJ3HPk2hksPOdfXP1rDR2TvEDmSmjLdEQBjyGp5VQo9hMj
	9PjLEkjk0RT
X-Gm-Gg: AYBFou1Y6+9k/phRGhPxxGZwxJp3v98eL+uVUoDFPE/ZdHc9MhTxbwWyRGk3pcbY2xr
	8tOnzKnr5WiyGDH1zE7pB22g2ev6EOGy/8kPswAOB/tU3lxUv+JjzlXtay5EMOIn8xGlbNUXWzX
	TwlFZyxy4yu03W7aS2TMbh2VRo9XzqmEThLv3xm1HJTTvSU/z+Qk7/CYMn9f6ky4vYdqOYlB0Zu
	1BYwOqcia3m+0/HPda9cfj16uVF0VkHRRfcdYLYXyUvwTG9CudOgcQwIwYHDnnJWewYKpHsEIMm
	A54I+kN6FC+Xgmu+US9Z/I1005kaZqiCSG7I7qFU0reJIfoConQyKbBN551jrdXxax7eAOGhngc
	KMhnn328XLHH3krqHH4pL8CmsTGYLItMugu3yUq8B8ecst8s0VDWuqqRj2QP7s6f6/+DURZStE+
	gC7jrNlrFUYuPPdCqEn5N4Wa8JxmJv01X1pfI=
X-Received: by 2002:a05:6102:6e8a:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7cea15c6056mr1308595137.33.1793130835826;
        Tue, 27 Oct 2026 12:53:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99125a034d0sm24824241.15.2026.10.27.12.53.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 12:53:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso1557243eec.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793130833; x=1793735633; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKQwMeScS+PX5JUNa6XWM6x1Yoqw40pYA0rCkxXqaZk=;
        b=bZKT1suuDd6TN2Wzupn4YVNCY4F83NUmIXxhTho9009BXdXjA/pzIXnWnv6xW3adhg
         iLgEmd6W/Lz3tXEFHsrKqKP0BZ++yyPENc+2iPNTb83GNIFN6OtU7z4TRhUXkqWA9W31
         L6ssJ8yLacvqudZniW9OkTivH5I6M+Juf6ECQ=
X-Received: by 2002:a05:701b:204a:10b0:195:8fa1:b447 with SMTP id a92af1059eb24-1a3c84c2907mr4924313c88.12.1793130833269;
        Tue, 27 Oct 2026 12:53:53 -0700 (PDT)
X-Received: by 2002:a05:701b:204a:10b0:195:8fa1:b447 with SMTP id
 a92af1059eb24-1a3c84c2907mr4924282c88.12.1793130832563; Tue, 27 Oct 2026
 12:53:52 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
In-Reply-To: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 27 Oct 2026 15:53:14 -0400
X-Gm-Features: AclHuK-F18nvTvqoqamjXK5cvdQV2vsNfHTI8WM6VpKjmOmHT37WKSxVvz9k2nQ
Message-ID: <CAKekbet7B=EvD+3Q9PFJAOJZvpz_hCn_dU__e+3=qhsFet=FVQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mmc: core: Keep the card powered across suspend
 when firmware needs it live
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000656820065ed7ce7a"

--000000000000656820065ed7ce7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:41=E2=80=AFAM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware accesse=
s the
> card directly during resume from Suspend-to-DRAM, before the kernel's own
> resume path runs, in order to load boot code using hard wired logic that =
is not
> field updatable. The card needs to stay powered and responsive for that a=
ccess
> to succeed, and since it is never power-cycled, it also needs to be reset
> before the kernel reuses it after resume.
>
> Changes in v10:
>         - To help out with the implementation I offered my help to try to=
 move
>         this forward.
>         - The DT patches are good to go so I included them from the previ=
ous
>         versions.
>         - Patch 3 to 6 are new, but based on the work done by Kamal Dasu.
>         - This is completely untested from my side, please help to test i=
t.
>
> Kind regards
> Ulf Hansson
>
>
> Kamal Dasu (2):
>   dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
>   dt-bindings: mmc: Add reset-card-at-resume property
>
> Ulf Hansson (4):
>   mmc: core: Add option to keep an eMMC powered on at system suspend
>   mmc: core: Split sdio_set_host_pm_flags()
>   mmc: core: Move reset functions for eMMC
>   mmc: core: Add support for resetting an eMMC at system resume
>
>  .../bindings/mmc/mmc-controller-common.yaml   | 10 +-
>  drivers/mmc/core/core.c                       |  9 ++
>  drivers/mmc/core/core.h                       |  1 +
>  drivers/mmc/core/host.c                       | 10 ++
>  drivers/mmc/core/mmc.c                        | 95 ++++++++++++-------
>  drivers/mmc/core/sdio_io.c                    |  7 +-
>  include/linux/mmc/host.h                      |  1 +
>  7 files changed, 92 insertions(+), 41 deletions(-)
>
> --
> 2.43.0
>

Hi Ulf,

Test results for this series on a Broadcom STB board with the Kioxia
016G01 eMMC,
which reproduces the problem during S3 suspend/resume with two DT variables=
:

  keep-power-in-suspend  reset-card-at-resume  Result
                            no                     no
  enters suspend, board resets

      at resume
                            yes                    no
  enters suspend, board resets

       at resume
                            no                     yes
  suspend aborts, -EINVAL
                            yes                    yes
  s3 suspend/resume works

Changes applied to Kernel: v7.3 + 7.4 merge window (linus/master
d135ab453a74) with this
series, plus the one-line fix I'm sending in reply to patch 6/6
(details in my reply to that patch):
mmc_resume() calls _mmc_hw_reset() without claiming the host, which
triggers WARN_ON(!host->claimed) for every command sent during the
reset. Claiming the host around the reset removes the warnings..

The -EINVAL in the third row comes from mmc_host_class_prepare(), since
MMC_PM_KEEP_POWER is not in pm_caps without keep-power-in-suspend.

In the working case I also checked the md5sum of the first 5 MiB of
/dev/mmcblk1 before and after suspend, and it is unchanged.

With the fix applied:
Tested-by: Kamal Dasu <kamal.dasu@broadcom.com>

Regards

Kamal

--000000000000656820065ed7ce7a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg8R+lnlUs4FgLjNN/
k06UT2PhH6iujx4QnCZlb47v+NAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMDI3MTk1MzUzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAo8fxVwxUhQaQiAHb9zrEriq1XTnCWxvRHE5r0UEZ1pST8Jqylox1
vlyFD4ZMPgeTya48nr3FdsYiqO4jLiO0WzEWFQa3P0RqafZYpVtHPB4YWC9FO5yc0SPrrsrnvloJ
cm/4Kp+X+WcB9JE6F3Tll+8OSAkNzumG1wyv170q+o4+yRgWIVtJewbil+T+STlMhkwHeOhbiF3l
ZpGgnw5uF+S4xsmkKR0a0Fo1uqXkQsWgBK942aQoRKMjOizAfvujUydxiVa6AIV+w2J/MmqPyKY2
tn8zybHb1yzjW9KVoJWMXmnD5Yt/NO8hftsRGAlUMQDSjWkrI7xKt2dMB+5cqg==
--000000000000656820065ed7ce7a--
