Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5661AAE17
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326919; cv=none; b=LjVw3QFZJcn7R7X5apr7rXjdbNRjgSEXcnZIrWtv28djX4AeBjbjFKQVK6gfn1ejkOKssRh1WWbY20YOpSJFqXEmQSSI/No7Ul6iN2b/fH3lhCYcwhQkcdo/WVmhirhsS5q+jKIXelvE8RfbqjkG7rNFLt0Sq/roaTBJ69dfnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326919; c=relaxed/simple;
	bh=VCKIrR5+1ZHGvP3luUDEL+idgQ4cf/Inp5snSTF8ZiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uR/sxxED6eb4ck++F+ua6cGW0EUHQ90npicPZJp4UsntG/HW9OJwaAELHgrZ1vNlYolv8G4OZt6JES5zD7+qaPaxdWpuDOA+73KRkxUrsY86HEBH2a18lRvf+Zyo6MUaqo3hf14Oc5NRyHVIR9jD6wG6kvYR5PGjYqPpfDlpofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhFU9hkM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhFU9hkM"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697b8540279so2342488a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326917; x=1782931717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xHHH8EY9OjAGpwdn1L/zV/NIcstDSDoYk+ngRQnWH3c=;
        b=nhFU9hkMIi5mWAQdT43XJxR96NvjncKzm0bBHxkVPNTwK+DaLj6/SkLTM3CKT1W4bQ
         yInoQtMLluibQ0fnKqLjnjm5ydAdrdYHwqlAx6LIJ1dtEpg9EuqccQiZayBl4k/zszrC
         izKvLaQPVVryD3t0Fh1trkzFJ5ekbwcVQESdOL7uVWLO5vUaiFGXc9aAzH3yziaYFXHs
         n8c7c5Sv5MXBky9IEl9rC5fnAFS7Xu6WVv8oGA+1w8SM5z7612iYOgVyQzW5cTvnVaJU
         rY8dqp6mRmRnk35jS+8JqP9MvhmGNUEIrKJCjKN0Z9+IZrClZ3epgPe5RJ0XIk2rUGo3
         eWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326917; x=1782931717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHHH8EY9OjAGpwdn1L/zV/NIcstDSDoYk+ngRQnWH3c=;
        b=Ajh3bEeWR0v8HKv22ZGN2EdCKNNZ+ZYRz7hWCMtszrDWNcuzjuLke1gSRBso5ytdTP
         TzHAZm50WugxxlezGj08WzAhJBA79xcwpNZx/gVzEAxtNgLzpamu+uHErn31yHzPR4XM
         vLzfDlhWW7TEcmI/UxTqlPKoYMP+E00b7fZUUEqB+uG/sErlTlHWSJ3sHnh9h3Rl7MYK
         vQs27yWku9nM3WNIjfoKcHol8GUot/CxehBqI5zDLG/vra2NNNMTz9FJ+D9t2fl2t46D
         5gJUdbGcnY1H+EyWqBYYsetg7EJ6TX0U0YVwBrnr4C8/ZUhTWqsttuV6AEbeSQzq1Jkg
         lt5w==
X-Gm-Message-State: AOJu0YyxH0FSwFANZi7ZTGTrv7fdx2a9PaJokovML1H0DGZuTvxG7C2v
	fvpqTdAIlLN+LAhbH76Cx8CH1PjV4+48DSDF3WkGFlCQTRzjVypqIixfZiii+Q==
X-Gm-Gg: AfdE7cnqqhgCRt66rVvOCzhoIGRybiyfGV+FO5Z54mVv6cWTP8SE0ay0w0HpQfrZ76O
	8Oc4NsnFkoUhwyF5YurvSNkgoYPt5kE/IsnJXiAhi5cg1e/2iWkfsn+sWb2NoHQN0i/JBKa0goJ
	4J6xsQayZfvAR67Or1pHU6hcDF1X1lcAAFD3ZzrrpsyFh5G6gy7yHUWlKwl/BVm9IBWmAq5VPWO
	1Hi7GmIxYPBfB4U61RzFb+8pzq1lXe/UgRPuomNnkkkPywD0jY9n5LctTV4qy2LuHlchFfD9AJB
	DaDoEk1F9TfiG+JzTYC9eyFNRgDa92yGsz69FGcgIV++IfO0G6VXrQaAoXywrQDwdnm6MoKISdp
	Y85hUOY0l6zb/gSeehdapNpW2JlbHRTGtD55YNsdUpvFsuhY8aA7LWNZ2Pj9qVeE8s9xAc1OIqF
	owZhQZkb98gKyM5i8lwwLJcOSECzo=
X-Received: by 2002:a05:6402:34c9:b0:697:f70f:8238 with SMTP id 4fb4d7f45d1cf-697f70f88a1mr2287769a12.4.1782326916771;
        Wed, 24 Jun 2026 11:48:36 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:91be:16ef:9f06:8b10])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm1659189a12.3.2026.06.24.11.48.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:48:35 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Subject: [PATCH v4 0/3] mmc-utils: improve lsmmc usability
Date: Wed, 24 Jun 2026 20:48:21 +0200
Message-ID: <20260624184824.2215718-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves lsmmc in three areas: external manufacturer ID files
and accepting /dev and /sys/block paths for register reads, an mmc list
command, and bash completion for mmc-utils.

Changes since v3 (review by Avri Altman):
- Patch 1 didn't compile on its own: the mmc list implementation
  (find_block_devname, print_list_entry, do_list, month_name) had
  accidentally been committed in this patch instead of the "Add mmc
  list command" patch. Moved all of it out, and squashed in the
  former patch 2 ("Accept /dev and /sys/block paths for register
  reads") since the two don't have independent value split apart from
  the list command.
- Patch 2 (Add mmc list command): now contains the full mmc list
  implementation that previously leaked into patch 1.
- Patch 3 (Add bash completion): subcommand completion is now driven
  by parsing 'mmc help' output instead of maintaining a parallel
  hardcoded verb list, so it stays in sync as commands are added or
  removed.

Torstein Eide (3):
  mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
    paths
  mmc-utils: lsmmc: Add mmc list command
  mmc-utils: Add bash completion

 Makefile           |  11 +-
 completion/mmc     |  52 ++++
 docs/HOWTO.rst     |  77 +++++-
 lsmmc.c            | 621 ++++++++++++++++++++++++++-------------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 ++
 8 files changed, 533 insertions(+), 274 deletions(-)
 create mode 100644 completion/mmc
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

-- 
2.53.0

