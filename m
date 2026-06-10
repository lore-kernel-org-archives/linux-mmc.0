Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004229D26B
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110948; cv=none; b=buGi1N4bZXlOVm1h2vw7VAAzHnNzvVXePI9Ts7wAxucoKNOigkXWT67QulqV7qWkKWEBiu5b//cIKI5qB4fh3zLHUzpn3UCts8wy+eKdFwbFEQDVyLg6mtz7nqRJKXjje7VErve0yokjwYdTfdW56tHC+qOLVjZsOHjXrW/qvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110948; c=relaxed/simple;
	bh=tzdDtmXwdGqs2dvs8mSu5iw8rbiEAIOik+tEumx3BXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQd/UpbwtxjeP1Nh8SGc69HT34FiIv3H5xKJSObJTbLf+6rN3AyCFyJqnNlDToKk7oS9SBqTNCM1pwaO9bNMbDFpVGBc9AbsPp93IXKT/FfwBedwE/Uq+fFkTi+CDAEobOc3w0yTNFM11gSWmT0x0orftnt+gwBgUPZ1us4lU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DRueSd5Z; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DRueSd5Z"
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-137dd523634so11112522c88.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 10:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110946; x=1781715746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYUHjYKhInE2lNVJHjGKu4tZFN74W1EK80V7x5LOWEI=;
        b=niXrrfW1fVo/4/xV+ryQNOIjXb/PyJftrDHeZJn7/UQbqjHbTvKBV3aWK93/Qy0qpH
         8St7jMenopr8JAJrqy2M7ZB6hBWcZuVo64UVroF2L3orTVLvspnEHIvGakTCv43KBcCY
         Qst+pJZbVfK18zaVI+6e0M520stVKY96dLxOHoaDCfI9GBRtzJSKFUF7efxHwcvHkthG
         Oh+d+db4OIUcwkArsZ9AOooBqbw5B09ZocTfV7UMe+Map4EIZXEd2moTxmrHDvonfcLK
         3ZgGi2X4NxGAuIXDpIDTyXQxHRyaIzh5xCh70p9eBGCHwzV4fzwRGyclDDekBPXCQI3Y
         x21w==
X-Forwarded-Encrypted: i=1; AFNElJ/sUTL4f9SvxqKtnACdD+o/XkCk3kB4D1WW5buCjUcIdyyaMfZ195VeTyzmUvm4FZu3iph7ZZM3UKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPFMP3aDjmsOmDr6T9xrUCYgXLVbZmpDunbFVbItPSUH0el2y
	kJ2KPmwdjyQzjr2hmTQHKN+Jz3DGONF4egopIVI53K3TStDyvI750KaFQ9zIDHtag/yeHEF6WsK
	JB5T4JWObUTLtJYU3npxfeZjoK08eHo3AD9If9ueigD9019RSTev/MHyR8GjUcXMaDXeWutbKfh
	BkQNLjVSjKOQkBQMBCIO3QM8/duYoK2QIpX6xp82eO4gG22giZ/lwZ3pXUDvrHcqleukbjRr1Fh
	SeIdH1lLLjz
X-Gm-Gg: Acq92OEoNtmBIa/Q++1xAVhaqKiHZ27PZYj4EtUf5FlAkLJDZQftuGuZXlSggAUliLE
	m5n0YFNwZmVZwFM++aYS2ED83JFbwW0T+O1/f27LhXcOPh//l9tpLRbi/TPYR7NmS20zLuIQQlw
	BDkfDb934oi9BVPNfeK7K1ltmbuNvlGrphVarhw69BMXPSa8rWfTCsaPXwqFD6gsKiz7LY/tW2b
	iit71zakORJpWovpQJmmISSXByGL/CLJqBYCZsi4HXZzCiLFXkElJz5/3K2ybT3sV+A5ZLLDYt/
	ADm5zlZbwVCiezlah7mJtNxjlhtr7jrr+lNGiMuCrgtmWGI9NIRIFaJJ+1R0TQM2aV8beZm38d6
	wJdnTUgVQw5v3WWssY/nk1XJSEcB8Gk7nsHK9BQKHY3xHbEYza8S6kUQF67qF8PLjhxBfZLPZoJ
	YGnUdlhk4GD+7AniVlk/39NrStLVEHgo4Fn5pV+0cBNp0Z3qmAWVSI+LBc8mZrH5l4/M4=
X-Received: by 2002:a05:7300:2211:b0:307:3a6c:ece9 with SMTP id 5a478bee46e88-307ff5734bbmr4541eec.15.1781110945332;
        Wed, 10 Jun 2026 10:02:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ceccb98c16sm14304956d6.6.2026.06.10.10.02.24
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2026 10:02:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304dd917645so7964506eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781110944; x=1781715744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYUHjYKhInE2lNVJHjGKu4tZFN74W1EK80V7x5LOWEI=;
        b=DRueSd5ZilJIjuYH0ANDlUUa+dr/A9wWr2Zg6jRjEMk7Q3TnOYlC5a1bhXluJ2drKo
         qPp/LW8rRy5s+exrjugl1vrrrEaZ3ZZRD7z93EpL+15MI1hx5uftAPstyJxBkR455JMF
         HLieC6S5b9w11XHLKfkCjS20qp9TrH/cO2EzU=
X-Forwarded-Encrypted: i=1; AFNElJ8WKKJqXPXg8Pf+VfSytOOoC250V6JotWFzUYY+LCrb5MRL98LHvQG1dDobpNgL0C13QCgJZjvk6gg=@vger.kernel.org
X-Received: by 2002:a05:7022:609b:b0:137:eb26:10d with SMTP id a92af1059eb24-13840a58bf0mr31533c88.0.1781110943289;
        Wed, 10 Jun 2026 10:02:23 -0700 (PDT)
X-Received: by 2002:a05:7022:609b:b0:137:eb26:10d with SMTP id
 a92af1059eb24-13840a58bf0mr31381c88.0.1781110942159; Wed, 10 Jun 2026
 10:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com> <CAKekbesT-CazRUv-LMU92h8pPP06PdrP8PQSTQZkeJs8vUePXw@mail.gmail.com>
In-Reply-To: <CAKekbesT-CazRUv-LMU92h8pPP06PdrP8PQSTQZkeJs8vUePXw@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Wed, 10 Jun 2026 13:01:43 -0400
X-Gm-Features: AVVi8CeQqMjc6iXtabPerPOUXM2h0VdoEoF6ahT0tY4dyVAS5znCPwKVdJvck0Q
Message-ID: <CAKekbes22Es97vR39y==Ds-VszAOo0ypwYhVT2ODbSpkb=cZfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mmc: Add pstore backend for crash dump storage on eMMC
To: Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020b41a0653e9351f"

--00000000000020b41a0653e9351f
Content-Type: multipart/alternative; boundary="000000000000037c2f0653e93594"

--000000000000037c2f0653e93594
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 12:53=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.co=
m> wrote:

>
>
> On Wed, Apr 22, 2026 at 4:51=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.c=
om>
> wrote:
>
>> This series adds mmcpstore, a pstore backend driver that enables
>> persistent storage of kernel crash logs on eMMC devices. When the
>> kernel panics, pstore captures the kmsg dump and writes it directly
>> to a dedicated MMC partition using polled I/O with interrupts
>> disabled.
>>
>> Changes since v4 (addresses Ulf Hansson's feedback on the v4 panic
>> host path, linux-mmc):
>> - mmc_panic_claim_host(): log claimed, runtime suspend, and
>>   ongoing_mrq before claim; always call panic_prepare() when
>>   implemented so the host can drain or gracefully terminate
>>   in-flight requests, then force-claim. Vendor controllers may
>>   supply their own panic_prepare for platform-specific cases (1/4).
>> - SDHCI: reference panic_prepare implementation; longer drain/reset
>>   timeouts; document panic helper return values in kernel-doc (2/4).
>> - mmcpstore: single prepare/claim path; panic_complete() after
>>   panic_poll_completion() on panic writes (4/4).
>>
>> Changes since v3:
>> - Fixed kernel-doc warnings reported by kernel test robot:
>>   - Added missing @param descriptions for sdhci_panic_prepare(),
>>     sdhci_panic_poll_completion(), sdhci_panic_complete() (patch 2)
>>   - Added missing @sect_offset param doc for
>>     mmcpstore_do_request_internal() (patch 4)
>>   - Fixed kernel-doc function name mismatch: mmcpstore_read() ->
>>     mmcpstore_read_zone() (patch 4)
>>   - Added missing @disk param doc for mmcpstore_card_add() (patch 4)
>> - Removed unused 'offset_bytes' variable in
>>   mmcpstore_register_for_card() (patch 4)
>>
>> Changes since v2 (RFC):
>> - Rebased onto v7.0-rc =E2=80=94 no longer reverts any existing MMC core
>>   or SDHCI changes (v1/v2 accidentally reverted recent upstream
>>   commits due to being based on an older tree)
>> - Removed all erase/bitmap tracking logic =E2=80=94 MMC/eMMC is managed
>>   flash and does not need erase-before-write; the pstore_zone
>>   framework handles zone management internally
>> - Uses standard MMC core request path (mmc_start_request) instead
>>   of hand-building mmc_request structs; panic-context I/O is
>>   handled through proper mmc_host_ops callbacks rather than ad-hoc
>>   code in the driver
>> - Added panic-context ops to mmc_host_ops and sdhci_ops for clean
>>   separation of panic and normal I/O paths
>> - Fixed deadlocks caused by spinlock contention during panic
>>   (lockless mmc_panic_claim_host using WRITE_ONCE)
>> - Fixed data corruption in pstore recovery (zlib_inflate failures)
>>   by letting the normal sdhci_request() path run instead of a
>>   custom panic request handler
>> - Added PM suspend/resume support with eMMC re-initialization
>> - Supports module loading or builtin loading of the driver
>> - Added MAINTAINERS entry
>> - Split into 4-patch series for reviewability
>>
>> The series is structured as follows:
>>
>> Patch 1 adds panic-context operations to struct mmc_host_ops and a
>> lockless mmc_panic_claim_host() for use during kernel panic when
>> other CPUs are stopped and may hold locks. Host drivers may replace
>> panic_prepare with vendor-specific code where needed.
>>
>> Patch 2 implements the SDHCI reference panic_prepare (graceful
>> termination of in-flight work, then polled completion paths); other
>> MMC host drivers use the same mmc_host_ops hooks with their own
>> panic_prepare where the hardware differs.
>>
>> Patch 3 adds mmc_blk_get_card_by_name() helper to look up an
>> mmc_card from a block device name, used by the mmcpstore module
>> path for card discovery.
>>
>> Patch 4 adds the mmcpstore driver itself, which registers with the
>> pstore_blk framework and handles panic writes, PM suspend/resume,
>> and dual-path registration (direct probe hook for builtin,
>> mmc_blk_get_card_by_name() for module). Also adds probe/remove
>> hooks in block.c and declarations in block.h for the builtin path.
>>
>> Tested on Broadcom STB platforms (ARM64) with SDHCI controllers,
>> verified panic dump recovery across multiple panic/reboot cycles
>> with kmsg, pmsg, and console pstore; also tested with concurrent
>> I/O stress before panic.
>>
>> Previous submissions and related work:
>>   RFC v1:
>> https://lore.kernel.org/linux-mmc/20221216212738.7928-1-kdasu.kdev@gmail=
.com/
>>   RFC v2:
>> https://lore.kernel.org/linux-mmc/20221222185948.12717-1-kdasu.kdev@gmai=
l.com/
>>   v3:
>> https://lore.kernel.org/linux-mmc/20260319185705.1516950-1-kamal.dasu@br=
oadcom.com/
>>   v4: linux-mmc (same thread as v3; superseded by this v5)
>>   Marvell MMC pstore attempt (2020):
>>
>> https://lore.kernel.org/linux-mmc/20201207115753.21728-1-bbudiredla@marv=
ell.com/
>>   pstore/blk documentation:
>>     https://www.kernel.org/doc/html/latest/admin-guide/pstore-blk.html
>>
>> Kamal Dasu (4):
>>   mmc: core: Add panic-context host operations for pstore backends
>>   mmc: sdhci: Implement panic-context write support
>>   mmc: block: Add helper to look up mmc_card by device name
>>   mmc: core: Add MMC pstore backend driver
>>
>>  MAINTAINERS                  |    6 +
>>  drivers/mmc/core/Kconfig     |   12 +
>>  drivers/mmc/core/Makefile    |    1 +
>>  drivers/mmc/core/block.c     |   56 ++
>>  drivers/mmc/core/block.h     |   18 +
>>  drivers/mmc/core/core.c      |   54 ++
>>  drivers/mmc/core/mmcpstore.c | 1511 ++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci.c     |  173 +++-
>>  drivers/mmc/host/sdhci.h     |    6 +
>>  include/linux/mmc/host.h     |   12 +
>>  10 files changed, 1845 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/mmc/core/mmcpstore.c
>>
>> --
>> 2.34.1
>>
>


Ulf,

I'm resending a gentle reminder regarding the v5 patch series for mmcpstore=
.

This version addresses your previous feedback on the v4 panic host path and
includes several key stability improvements:

- Implements a lockless mmc_panic_claim_host using WRITE_ONCE to avoid
deadlocks during panic.
- Adds panic_prepare to the host ops to ensure in-flight requests are
drained and runtime PM states are handled before panic writes.
- Uses standard MMC core request paths with polling-based completion for
robust I/O during a crash.
- Includes full PM suspend/resume support with eMMC re-initialization.

The series has been tested thoroughly on Broadcom STB platforms (ARM64),
verifying reliable recovery of kmsg, pmsg, and console logs across multiple
panic cycles.

Please let me know if you need any further information or if there are
additional changes required for acceptance.

Thanks

Kamal

--000000000000037c2f0653e93594
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 10,=
 2026 at 12:53=E2=80=AFPM Kamal Dasu &lt;<a href=3D"mailto:kamal.dasu@broad=
com.com">kamal.dasu@broadcom.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Ap=
r 22, 2026 at 4:51=E2=80=AFPM Kamal Dasu &lt;<a href=3D"mailto:kamal.dasu@b=
roadcom.com" target=3D"_blank">kamal.dasu@broadcom.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">This series adds mmcp=
store, a pstore backend driver that enables<br>
persistent storage of kernel crash logs on eMMC devices. When the<br>
kernel panics, pstore captures the kmsg dump and writes it directly<br>
to a dedicated MMC partition using polled I/O with interrupts<br>
disabled.<br>
<br>
Changes since v4 (addresses Ulf Hansson&#39;s feedback on the v4 panic<br>
host path, linux-mmc):<br>
- mmc_panic_claim_host(): log claimed, runtime suspend, and<br>
=C2=A0 ongoing_mrq before claim; always call panic_prepare() when<br>
=C2=A0 implemented so the host can drain or gracefully terminate<br>
=C2=A0 in-flight requests, then force-claim. Vendor controllers may<br>
=C2=A0 supply their own panic_prepare for platform-specific cases (1/4).<br=
>
- SDHCI: reference panic_prepare implementation; longer drain/reset<br>
=C2=A0 timeouts; document panic helper return values in kernel-doc (2/4).<b=
r>
- mmcpstore: single prepare/claim path; panic_complete() after<br>
=C2=A0 panic_poll_completion() on panic writes (4/4).<br>
<br>
Changes since v3:<br>
- Fixed kernel-doc warnings reported by kernel test robot:<br>
=C2=A0 - Added missing @param descriptions for sdhci_panic_prepare(),<br>
=C2=A0 =C2=A0 sdhci_panic_poll_completion(), sdhci_panic_complete() (patch =
2)<br>
=C2=A0 - Added missing @sect_offset param doc for<br>
=C2=A0 =C2=A0 mmcpstore_do_request_internal() (patch 4)<br>
=C2=A0 - Fixed kernel-doc function name mismatch: mmcpstore_read() -&gt;<br=
>
=C2=A0 =C2=A0 mmcpstore_read_zone() (patch 4)<br>
=C2=A0 - Added missing @disk param doc for mmcpstore_card_add() (patch 4)<b=
r>
- Removed unused &#39;offset_bytes&#39; variable in<br>
=C2=A0 mmcpstore_register_for_card() (patch 4)<br>
<br>
Changes since v2 (RFC):<br>
- Rebased onto v7.0-rc =E2=80=94 no longer reverts any existing MMC core<br=
>
=C2=A0 or SDHCI changes (v1/v2 accidentally reverted recent upstream<br>
=C2=A0 commits due to being based on an older tree)<br>
- Removed all erase/bitmap tracking logic =E2=80=94 MMC/eMMC is managed<br>
=C2=A0 flash and does not need erase-before-write; the pstore_zone<br>
=C2=A0 framework handles zone management internally<br>
- Uses standard MMC core request path (mmc_start_request) instead<br>
=C2=A0 of hand-building mmc_request structs; panic-context I/O is<br>
=C2=A0 handled through proper mmc_host_ops callbacks rather than ad-hoc<br>
=C2=A0 code in the driver<br>
- Added panic-context ops to mmc_host_ops and sdhci_ops for clean<br>
=C2=A0 separation of panic and normal I/O paths<br>
- Fixed deadlocks caused by spinlock contention during panic<br>
=C2=A0 (lockless mmc_panic_claim_host using WRITE_ONCE)<br>
- Fixed data corruption in pstore recovery (zlib_inflate failures)<br>
=C2=A0 by letting the normal sdhci_request() path run instead of a<br>
=C2=A0 custom panic request handler<br>
- Added PM suspend/resume support with eMMC re-initialization<br>
- Supports module loading or builtin loading of the driver<br>
- Added MAINTAINERS entry<br>
- Split into 4-patch series for reviewability<br>
<br>
The series is structured as follows:<br>
<br>
Patch 1 adds panic-context operations to struct mmc_host_ops and a<br>
lockless mmc_panic_claim_host() for use during kernel panic when<br>
other CPUs are stopped and may hold locks. Host drivers may replace<br>
panic_prepare with vendor-specific code where needed.<br>
<br>
Patch 2 implements the SDHCI reference panic_prepare (graceful<br>
termination of in-flight work, then polled completion paths); other<br>
MMC host drivers use the same mmc_host_ops hooks with their own<br>
panic_prepare where the hardware differs.<br>
<br>
Patch 3 adds mmc_blk_get_card_by_name() helper to look up an<br>
mmc_card from a block device name, used by the mmcpstore module<br>
path for card discovery.<br>
<br>
Patch 4 adds the mmcpstore driver itself, which registers with the<br>
pstore_blk framework and handles panic writes, PM suspend/resume,<br>
and dual-path registration (direct probe hook for builtin,<br>
mmc_blk_get_card_by_name() for module). Also adds probe/remove<br>
hooks in block.c and declarations in block.h for the builtin path.<br>
<br>
Tested on Broadcom STB platforms (ARM64) with SDHCI controllers,<br>
verified panic dump recovery across multiple panic/reboot cycles<br>
with kmsg, pmsg, and console pstore; also tested with concurrent<br>
I/O stress before panic.<br>
<br>
Previous submissions and related work:<br>
=C2=A0 RFC v1: <a href=3D"https://lore.kernel.org/linux-mmc/20221216212738.=
7928-1-kdasu.kdev@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/linux-mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/</a><b=
r>
=C2=A0 RFC v2: <a href=3D"https://lore.kernel.org/linux-mmc/20221222185948.=
12717-1-kdasu.kdev@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https:/=
/lore.kernel.org/linux-mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/</a>=
<br>
=C2=A0 v3: <a href=3D"https://lore.kernel.org/linux-mmc/20260319185705.1516=
950-1-kamal.dasu@broadcom.com/" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/linux-mmc/20260319185705.1516950-1-kamal.dasu@broadcom.co=
m/</a><br>
=C2=A0 v4: linux-mmc (same thread as v3; superseded by this v5)<br>
=C2=A0 Marvell MMC pstore attempt (2020):<br>
=C2=A0 =C2=A0 <a href=3D"https://lore.kernel.org/linux-mmc/20201207115753.2=
1728-1-bbudiredla@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/linux-mmc/20201207115753.21728-1-bbudiredla@marvell.com/<=
/a><br>
=C2=A0 pstore/blk documentation:<br>
=C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/doc/html/latest/admin-guide=
/pstore-blk.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.o=
rg/doc/html/latest/admin-guide/pstore-blk.html</a><br>
<br>
Kamal Dasu (4):<br>
=C2=A0 mmc: core: Add panic-context host operations for pstore backends<br>
=C2=A0 mmc: sdhci: Implement panic-context write support<br>
=C2=A0 mmc: block: Add helper to look up mmc_card by device name<br>
=C2=A0 mmc: core: Add MMC pstore backend driver<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 6 +<br>
=C2=A0drivers/mmc/core/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A012 +<br>
=C2=A0drivers/mmc/core/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/mmc/core/block.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A056 ++<br>
=C2=A0drivers/mmc/core/block.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A018 +<br>
=C2=A0drivers/mmc/core/core.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A054 ++<br>
=C2=A0drivers/mmc/core/mmcpstore.c | 1511 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A0drivers/mmc/host/sdhci.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 173 +++-<br>
=C2=A0drivers/mmc/host/sdhci.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
=C2=A0include/linux/mmc/host.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A012 +<br>
=C2=A010 files changed, 1845 insertions(+), 4 deletions(-)<br>
=C2=A0create mode 100644 drivers/mmc/core/mmcpstore.c<br>
<br>
-- <br>
2.34.1<br></blockquote></div></blockquote><div><br></div><div><br></div><di=
v><br></div><div>Ulf,</div><div><br></div><div>I&#39;m resending a gentle r=
eminder regarding the v5 patch series for mmcpstore.</div><div><br></div><d=
iv>This version addresses your previous feedback on the v4 panic host path =
and includes several key stability improvements:</div><div><br></div><div>-=
 Implements a lockless mmc_panic_claim_host using WRITE_ONCE to avoid deadl=
ocks during panic.</div><div>- Adds panic_prepare to the host ops to ensure=
 in-flight requests are drained and runtime PM states are handled before pa=
nic writes.</div><div>- Uses standard MMC core request paths with polling-b=
ased completion for robust I/O during a crash.</div><div>- Includes full PM=
 suspend/resume support with eMMC re-initialization.</div><div><br></div><d=
iv>The series has been tested thoroughly on Broadcom STB platforms (ARM64),=
 verifying reliable recovery of kmsg, pmsg, and console logs across multipl=
e panic cycles.</div><div><br></div><div>Please let me know if you need any=
 further information or if there are additional changes required for accept=
ance.</div><div><br></div><div>Thanks</div><div><br></div><div>Kamal</div><=
br class=3D"gmail-Apple-interchange-newline"><div>=C2=A0</div></div></div>

--000000000000037c2f0653e93594--

--00000000000020b41a0653e9351f
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgAsuNbQDl5d5yJNC8
obq/wc4pm+iG4/eUwv8kWlYFCPUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwNjEwMTcwMjI0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAiLidxVdBjbOst1u2nyLn5zrDwVqJN8+exRU9oPWh41iIUKz3aTv7
YeX47cCiIi4aMJ8omc/bb5zAx2FYDL/EbhixtMX6zTnbz+hGdhyZG9jgfBiU6KkANe8lak3GJty1
XLLzuYm4M4Dw+kWfJqvxPY5wiQ9s6R1lqhaGNJgQseITVmAIjU56j6E2Uhbbsex6zvyg3kMLOtFy
rAIW7y5M9ihsJWGPSJEuSgl2VMD4a2iWBlptN03yO0Xe9I7j5vIGORhmy2+llnIAcN7ys11Ckhiv
Yo8bk6OGSXOu/Tf65gqK8JCkd0eS7FEROCnu4g5nP4+AyrFuhOgtm2KW66vyVA==
--00000000000020b41a0653e9351f--
