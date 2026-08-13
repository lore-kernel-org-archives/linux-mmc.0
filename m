Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F03F3294
	for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647123; cv=none; b=OE4P+I4TcCbE71ole3kfXbvaC9y6nT0RWA+o4CywLmr82XnWR3wLyUu/zoSW7hev1gv86078FKFHjO1MxCx4iexVYYeHZafyRojfWLDqk+O+PX0Jt+XKa5KtK7OGE5WlNzhXq7oUiWmwJX6+NB06GBb9LC+NHg8YmlI+355LUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647123; c=relaxed/simple;
	bh=6oZ4+PsTpagzQ+5DYDEDbmTiQq+gBFzebgzml2rYYZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDAlgdvmCAZGLWw0jvOF+qEFyjuHO65SF1ho+HsgyXm1hKwFmvoRDRvbRMVK7zGOaVdfEmdSEx89ckeGbsSoWs32x6Bys9ikMk2FgeBlyEHn8JnuSRby6cg1pzg02Jp8yqCAvR0B2gA4Pc6/ZMbUFe87eDksYACksOgcCJxsvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VDd3vg+b; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VDd3vg+b"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c9e7391839cso176517a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 11:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647120; x=1787251920;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxTJVkGMTbAW0EBsI5HIYClgZvRXfEKqw/lmguCyOTY=;
        b=fUgQt1/Ft2f3zjaK+vfh+3VsAmnp0msqc3UMB26JM/k4Tq2xN7etJQfqbijXY9ykQW
         JynXe4qE3ZBbyGn9bou9esQNZPVGH1FSt+3Z5jIVVUNVgRyQHPYiU7zxzEA2m8RSqG/F
         5+1tCkKMJwXqmXsDlem5srJ4dEbcjwvg3x3zRZFW1yl8TGZuLYSpffKaVF0syfv7uJwI
         mWPoP5VTfhlkb5YqDS9GObhaT8qi9v5jiJANki0g3gxmXYiAr6G60Vo7KivGKOhMDn7l
         Y+rJeJdVQ9Dp3c1EbyYWpJli9NU0pVclBg4DIoF+6KWiIeDbbKzh0evaF7cHsoRSHYu1
         kgAw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6urJsuZ10ASXryahiCXELE9Rk8gLWAUyjsDp2aHIYT7v2Uyvd+VkXJMspBfOsDUwz8JWl7M9dK8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKNxWF9avZbjdD7nKzCiOvMuOBw2FQDJX3k8aNvbheiY9J6lo
	qk43uBWxqDRnGM1t+531KkQ8/6wNRDHVVJs0gyXvYAtexOsJ1UebCXeRq0dZrRI2Wx3XqjmPlGh
	VLOImyMXOr/aMJLv/qlkU73PdJykVmbszQIjzl0tGT7NUAEfj9kkiPukbcLMVOq5d/qzljio7pV
	tvAIAxOBbKYNOyXtqhPH7l3Woisw236+X08l7s6+cFrqPURrViUsEn5cyOP2+b1vAxygBMq8Wso
	kZdIX982tZm
X-Gm-Gg: AR+sD12KBX7ZFa9+i6Pg3esnQwVGmvBAcZ/1uNUJ1Rvae2au4354GnL2U/Ln9GyskZS
	a+Nc7bVi221/sJ5Kv5Yd+ci7OxXlvlGBbZ2N3It6BaBIKT/TnVHcJ+AuyKuv1Fsl6rTSiaSaXcr
	h9UgrROd0lBEZ3YbYn3+suCg1U5S5iB+c52EkXjYVinnJJx+ZM2sWb3k7J9ZoW/sYivfbpJEDa2
	M/Z9DC+k8zJIuHHnVRg4z+sl+Y3A5ki17x19L5f2rTBERLxCIyno8PoBt/zyX4hXpLYLdfwqcc4
	7rx7tYaJeiMbGl1deUTAkTJ6ecfqSz05z90DlrieEQ86wv5M4ecYoDSc1I7f+GxH2ut2fWf2q3T
	1x+WDRLEq0i0owDyKP2xZe2NpZQ3FQe4jxaLzF7pnjTR0b4FZHj74HXdPeqz5PVQWLhCJcDEcDo
	MBju8zh87tyzBQCiIoPiXd7jTQ5sct0UFW
X-Received: by 2002:a05:6a21:350f:b0:3c3:6528:c87 with SMTP id adf61e73a8af0-3cc54f49c1emr10486664637.1.1786647119449;
        Thu, 13 Aug 2026 11:51:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbef6edd16dsm672135a12.9.2026.08.13.11.51.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 11:51:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbef7b172easo301747a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786647116; x=1787251916; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxTJVkGMTbAW0EBsI5HIYClgZvRXfEKqw/lmguCyOTY=;
        b=VDd3vg+b+p+F+MHfiFaCj55FTI97J8eGYV+GE6HQRvkSi1h9YkP+KXL2YH7EMSvJqx
         0yMwLVLI2p6sfYqmTgwnYH+nYBWhLCSf1xzslWTYW0Ip2Gl5lpkuuMmaEKbnNzv569g0
         ZWDT26wVhGqMaoG9xMCTQYs6Xs+ENZA3F83+Q=
X-Forwarded-Encrypted: i=1; AHgh+Ro/ZMDAWEsK2TcNyGEHe2Z+avjz8q6tHQB0kWmjzFaH4ytjq51hyZdMyHD/pZXiKgTa5p68CR0JXZE=@vger.kernel.org
X-Received: by 2002:a05:6a21:48d:b0:3c4:396d:4a6c with SMTP id adf61e73a8af0-3cc54f4940bmr10983640637.5.1786647115965;
        Thu, 13 Aug 2026 11:51:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:48d:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3cc54f4940bmr10983559637.5.1786647115291; Thu, 13 Aug 2026
 11:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
 <CAKekbesT-CazRUv-LMU92h8pPP06PdrP8PQSTQZkeJs8vUePXw@mail.gmail.com>
 <CAKekbes22Es97vR39y==Ds-VszAOo0ypwYhVT2ODbSpkb=cZfA@mail.gmail.com>
 <b6cdd25a-af18-40f4-8fc1-fac2e1d0ef41@broadcom.com> <1dc90386-11ff-4b95-a1c8-1365cad1b4d4@intel.com>
In-Reply-To: <1dc90386-11ff-4b95-a1c8-1365cad1b4d4@intel.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 13 Aug 2026 14:51:17 -0400
X-Gm-Features: AUfX_myB8_Q2_3RtJc6k4bghdzVn27MwMxCsjGzJkjIx8QobmfCUvM00ohn2tsQ
Message-ID: <CAKekbevG4dhefMmG0DBbR40=QC+tWWCX-UtFwDwzqyxjN3DoYw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mmc: Add pstore backend for crash dump storage on eMMC
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	William Zhang <william.zhang@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7f5560658f23251"

--000000000000b7f5560658f23251
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 4:26=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 11/08/2026 19:47, Florian Fainelli wrote:
> > Hi Ulf,
> >
> > On 6/10/26 10:01, Kamal Dasu wrote:
> >>
> >>
> >> On Wed, Jun 10, 2026 at 12:53=E2=80=AFPM Kamal Dasu <kamal.dasu@broadc=
om.com <mailto:kamal.dasu@broadcom.com>> wrote:
> >>
> >>
> >>
> >>     On Wed, Apr 22, 2026 at 4:51=E2=80=AFPM Kamal Dasu <kamal.dasu@bro=
adcom.com
> >>     <mailto:kamal.dasu@broadcom.com>> wrote:
> >>
> >>         This series adds mmcpstore, a pstore backend driver that enabl=
es
> >>         persistent storage of kernel crash logs on eMMC devices. When =
the
> >>         kernel panics, pstore captures the kmsg dump and writes it dir=
ectly
> >>         to a dedicated MMC partition using polled I/O with interrupts
> >>         disabled.
> >>
> >>         Changes since v4 (addresses Ulf Hansson's feedback on the v4 p=
anic
> >>         host path, linux-mmc):
> >>         - mmc_panic_claim_host(): log claimed, runtime suspend, and
> >>            ongoing_mrq before claim; always call panic_prepare() when
> >>            implemented so the host can drain or gracefully terminate
> >>            in-flight requests, then force-claim. Vendor controllers ma=
y
> >>            supply their own panic_prepare for platform-specific cases =
(1/4).
> >>         - SDHCI: reference panic_prepare implementation; longer drain/=
reset
> >>            timeouts; document panic helper return values in kernel-doc
> >>         (2/4).
> >>         - mmcpstore: single prepare/claim path; panic_complete() after
> >>            panic_poll_completion() on panic writes (4/4).
> >>
> >>         Changes since v3:
> >>         - Fixed kernel-doc warnings reported by kernel test robot:
> >>            - Added missing @param descriptions for sdhci_panic_prepare=
(),
> >>              sdhci_panic_poll_completion(), sdhci_panic_complete() (pa=
tch 2)
> >>            - Added missing @sect_offset param doc for
> >>              mmcpstore_do_request_internal() (patch 4)
> >>            - Fixed kernel-doc function name mismatch: mmcpstore_read()=
 ->
> >>              mmcpstore_read_zone() (patch 4)
> >>            - Added missing @disk param doc for mmcpstore_card_add()
> >>         (patch 4)
> >>         - Removed unused 'offset_bytes' variable in
> >>            mmcpstore_register_for_card() (patch 4)
> >>
> >>         Changes since v2 (RFC):
> >>         - Rebased onto v7.0-rc =E2=80=94 no longer reverts any existin=
g MMC core
> >>            or SDHCI changes (v1/v2 accidentally reverted recent upstre=
am
> >>            commits due to being based on an older tree)
> >>         - Removed all erase/bitmap tracking logic =E2=80=94 MMC/eMMC i=
s managed
> >>            flash and does not need erase-before-write; the pstore_zone
> >>            framework handles zone management internally
> >>         - Uses standard MMC core request path (mmc_start_request) inst=
ead
> >>            of hand-building mmc_request structs; panic-context I/O is
> >>            handled through proper mmc_host_ops callbacks rather than a=
d-hoc
> >>            code in the driver
> >>         - Added panic-context ops to mmc_host_ops and sdhci_ops for cl=
ean
> >>            separation of panic and normal I/O paths
> >>         - Fixed deadlocks caused by spinlock contention during panic
> >>            (lockless mmc_panic_claim_host using WRITE_ONCE)
> >>         - Fixed data corruption in pstore recovery (zlib_inflate failu=
res)
> >>            by letting the normal sdhci_request() path run instead of a
> >>            custom panic request handler
> >>         - Added PM suspend/resume support with eMMC re-initialization
> >>         - Supports module loading or builtin loading of the driver
> >>         - Added MAINTAINERS entry
> >>         - Split into 4-patch series for reviewability
> >>
> >>         The series is structured as follows:
> >>
> >>         Patch 1 adds panic-context operations to struct mmc_host_ops a=
nd a
> >>         lockless mmc_panic_claim_host() for use during kernel panic wh=
en
> >>         other CPUs are stopped and may hold locks. Host drivers may re=
place
> >>         panic_prepare with vendor-specific code where needed.
> >>
> >>         Patch 2 implements the SDHCI reference panic_prepare (graceful
> >>         termination of in-flight work, then polled completion paths); =
other
> >>         MMC host drivers use the same mmc_host_ops hooks with their ow=
n
> >>         panic_prepare where the hardware differs.
> >>
> >>         Patch 3 adds mmc_blk_get_card_by_name() helper to look up an
> >>         mmc_card from a block device name, used by the mmcpstore modul=
e
> >>         path for card discovery.
> >>
> >>         Patch 4 adds the mmcpstore driver itself, which registers with=
 the
> >>         pstore_blk framework and handles panic writes, PM suspend/resu=
me,
> >>         and dual-path registration (direct probe hook for builtin,
> >>         mmc_blk_get_card_by_name() for module). Also adds probe/remove
> >>         hooks in block.c and declarations in block.h for the builtin p=
ath.
> >>
> >>         Tested on Broadcom STB platforms (ARM64) with SDHCI controller=
s,
> >>         verified panic dump recovery across multiple panic/reboot cycl=
es
> >>         with kmsg, pmsg, and console pstore; also tested with concurre=
nt
> >>         I/O stress before panic.
> >>
> >>         Previous submissions and related work:
> >>            RFC v1: https://lore.kernel.org/linux-
> >>         mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/ <https://
> >>         lore.kernel.org/linux-mmc/20221216212738.7928-1-
> >>         kdasu.kdev@gmail.com/>
> >>            RFC v2: https://lore.kernel.org/linux-
> >>         mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/ <https://
> >>         lore.kernel.org/linux-mmc/20221222185948.12717-1-
> >>         kdasu.kdev@gmail.com/>
> >>            v3: https://lore.kernel.org/linux-
> >>         mmc/20260319185705.1516950-1-kamal.dasu@broadcom.com/ <https:/=
/
> >>         lore.kernel.org/linux-mmc/20260319185705.1516950-1-
> >>         kamal.dasu@broadcom.com/>
> >>            v4: linux-mmc (same thread as v3; superseded by this v5)
> >>            Marvell MMC pstore attempt (2020):
> >>         https://lore.kernel.org/linux-mmc/20201207115753.21728-1-
> >>         bbudiredla@marvell.com/ <https://lore.kernel.org/linux-
> >>         mmc/20201207115753.21728-1-bbudiredla@marvell.com/>
> >>            pstore/blk documentation:
> >>         https://www.kernel.org/doc/html/latest/admin-guide/pstore-
> >>         blk.html <https://www.kernel.org/doc/html/latest/admin-guide/
> >>         pstore-blk.html>
> >>
> >>         Kamal Dasu (4):
> >>            mmc: core: Add panic-context host operations for pstore bac=
kends
> >>            mmc: sdhci: Implement panic-context write support
> >>            mmc: block: Add helper to look up mmc_card by device name
> >>            mmc: core: Add MMC pstore backend driver
> >>
> >>           MAINTAINERS                  |    6 +
> >>           drivers/mmc/core/Kconfig     |   12 +
> >>           drivers/mmc/core/Makefile    |    1 +
> >>           drivers/mmc/core/block.c     |   56 ++
> >>           drivers/mmc/core/block.h     |   18 +
> >>           drivers/mmc/core/core.c      |   54 ++
> >>           drivers/mmc/core/mmcpstore.c | 1511 ++++++++++++++++++++++++=
++
> >>         ++++++++
> >>           drivers/mmc/host/sdhci.c     |  173 +++-
> >>           drivers/mmc/host/sdhci.h     |    6 +
> >>           include/linux/mmc/host.h     |   12 +
> >>           10 files changed, 1845 insertions(+), 4 deletions(-)
> >>           create mode 100644 drivers/mmc/core/mmcpstore.c
> >>
> >>         --         2.34.1
> >>
> >>
> >>
> >>
> >> Ulf,
> >>
> >> I'm resending a gentle reminder regarding the v5 patch series for mmcp=
store.
> >>
> >> This version addresses your previous feedback on the v4 panic host pat=
h and includes several key stability improvements:
> >>
> >> - Implements a lockless mmc_panic_claim_host using WRITE_ONCE to avoid=
 deadlocks during panic.
> >> - Adds panic_prepare to the host ops to ensure in-flight requests are =
drained and runtime PM states are handled before panic writes.
> >> - Uses standard MMC core request paths with polling-based completion f=
or robust I/O during a crash.
> >> - Includes full PM suspend/resume support with eMMC re-initialization.
> >>
> >> The series has been tested thoroughly on Broadcom STB platforms (ARM64=
), verifying reliable recovery of kmsg, pmsg, and console logs across multi=
ple panic cycles.
> >>
> >> Please let me know if you need any further information or if there are=
 additional changes required for acceptance.
> >
> > Is there anything we could do here to move this forward? We have large =
number of devices in the field that make use of that feature and we would r=
eally like for this to be included upstream and usable by others as well.
> >
> > Thanks!
>
> Perhaps start by describing the problem.  pstore_blk already supports
> block devices including mmc block devices, right?  Have you any
> information on how well that works in practice?  Is a dedicated mmc
> pstore back end really needed?
>
pstore must write kmsg to eMMC from inside panic() -- IRQs and
preemption already disabled, other CPUs stopped -- and complete
without sleeping, blocking on a lock, or waiting on an interrupt.
It lets you attach one (blkdev=3D/dev/mmcblk0pN). Attaching isn't the
same as working during a panic.
Not at all for an actual panic. Its own code says so on attach:
"attached %s (...) (no dedicated panic_write!)" (fs/pstore/blk.c:312).
Its write path also returns -EBUSY whenever irqs_disabled() -- always
true once panic() has run -- and no panic_write is registered, so
pstore's panic dispatch has nothing to call.

"Is a dedicated mmc backend really needed? "
Yes. pstore-blk.rst already documents that panic capture requires a
dedicated, polled, lock-free panic_write; mtdpstore is the existing
in-tree backend doing that for flash. This is the same pattern
applied to MMC.

> What are the generic requirements for a pstore backend?  How do they
> map to requirements for mmc?
>

panic_write must run synchronously, one CPU, IRQs/preempt already
off, complete-or-fail before returning: no sleep, no blocking lock,
no allocation, no interrupt-driven completion. That rules out
mmc_claim_host() (sleeps), mmc_wait_for_req()/mmc_wait_for_cmd()
(wait_for_completion -> schedule()), and blk-mq/mmc_queue (IRQ +
workqueue driven). The panic path instead builds raw mmc commands and
polls host registers directly for completion.

> How are big obstacles handled like:
> - the device is in use

force-claimed via WRITE_ONCE (host
lock not taken); in-flight command is drained with a bounded poll
(500ms) then aborted via software reset, not gracefully finished.

> - the device is runtime suspended
detected (pm_runtime_suspended()) and
logged; nothing resumes power before the write is attempted.

> - the controller is runtime suspended
same -- detected, not acted on.
Runtime PM transition underway: no check beyond that same read.

> - a runtime power management transition is underway
no check beyond that same read.

> - a system power management transition is underway
A PM notifier blocks read/write during PM_SUSPEND_PREPARE and re-inits
the card via
pm_runtime_get_sync() on PM_POST_SUSPEND -- but this notifier is
entirely separate from, and not consulted by, the panic write path.

> - reset or recovery is in progress
no interaction with mmc_hw_reset() or CQE recovery anywhere in the panic pa=
th.

> - the panic originates in the mmc subsystem

mmc_host->lock is bypassed  entirely (WRITE_ONCE, no lock taken) for
exactly this reason.
sdhci_host->lock is not treated the same way -- it's taken with a
plain spin_lock_irqsave(), no trylock, no bypass.

> - switching emmc partitions

the panic path can switch to its own  target partition (raw CMD6 +
busy poll). The previously-active
partition is saved (original_part_config) but never read back or
restored anywhere in the file.

> - device tuning / re-tuning

mmc_start_request(), called directly by the panic path, unconditionally cal=
ls
mmc_retune(), which if host->retune_now is set calls into
mmc_execute_tuning() ->
mmc_wait_for_req() -> wait_for_completion() -> schedule(). Nothing
checks or clears retune_now beforehand.

> - maybe other things?
>
None of the above interact with each other either
e.g.a partition switch and a runtime-suspended controller occurring
together are each handled (or not) independently, not as a
combined case.

> Is it so that in some cases the pstore back end needs to leave the
> mmc system in an operational state?  Whereas in a panic/oops it
> could leave it broken?
>
Nothing in the code releases the forced claim, re-initializes the
card, or restores state after a panic write. It does two bounded
delays and returns, leaving host->claimed forced, CQE off if
disabled, and the card on whichever partition was last selected. The
The implicit assumption is that a reboot follows eventually.

Thanks
Kamal

--000000000000b7f5560658f23251
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
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgiiSa9MK1LqTYpXIv
pMbUNOQitkL61ICjkUDNpFMDVNgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwODEzMTg1MTU2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAAklAxFZg7LUhQ0n5duM+WkcoflbWygniw9IW3OT8pIvT+WWWC2MH
fblCvHdPdBVf62PfgqjIdLQZ8zFNL/qDIJwCRgJQNVjSa1J4+2OvDmbEdDZvfJKL8bY+1ZBI/q9p
OCU/2jH7iC8zTwGkC6UJ/WCfFAomXebXdHgiE1bbLPM6pgYUeCejctmZUa+vAqoeNDogtKSeLMR1
X6AMs1muJu1AKxNCUXKG9gu4q6Db0/cxJ8AbNLv4f48IN2e+t7padR9u/vBQP4gs1Yaz9cmJclfy
4vT6rk5+HxSV+R6EIAclnWNkDLoPWJqaCXDBR5LNXdHNkXS10vPWuM3uTf9W9A==
--000000000000b7f5560658f23251--
