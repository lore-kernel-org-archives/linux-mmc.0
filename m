Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E315AC2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E8220661
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7L3GH7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgBMPnN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:43:13 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36676 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgBMPnM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 10:43:12 -0500
Received: by mail-lj1-f178.google.com with SMTP id r19so7140330ljg.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JwYIMGQOk6yTod1/avu+lWhhzqWkolvZorazJQ/e5vo=;
        b=f7L3GH7hb8TxsVSZle5VHmgjCNBDMD/Jz+PugJqwS7bdt1lxNyYFQ6Y9sXKI4v26Qa
         +Zw7oVpd7FI5ptlf36aIfLy34xPhlkXb48/epixfDzHfoSVS5Vk4ilHkupWTdHuSRITl
         zM2geoM6gwjXXpHhkUcXkwXHJNCTSbc0aVyLDdWBIVnmuKqz3rUQtK3xqsYnHo+OpD2U
         /z1U8rCw2fhJag15TRK8H4tvoktNOAAVa+/OpOJEHFtTJ5ME+twuxFsfcgVfeAGJlM1y
         Ap3UEMA4CAe3LFeDchj1LmaaRAObnfZwc6gYZMWoflkVi5n1wIs2RJ9JiVZV8iIP9owA
         FV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JwYIMGQOk6yTod1/avu+lWhhzqWkolvZorazJQ/e5vo=;
        b=NckCMgZV6tYXI95Q+xJjYdlzHzTAyAg3Ak03fydnHhZ9m8OzEVwgNLZZ5enOhau6+p
         SmwJ7CL9iihdB4eg1BCvefJc7IM2+H7zXVNfJpy22m5ZJZnlPV76W0Pb/UJcz5tcdQmP
         gf7DqWZmE3Frw3tuh/OCqKIujvQMCkZoK1XWoDzKUmoLitT3ippTAVHZ1Ehte4eVJOW/
         SrHSLOvsNn0KluWFCBzwHW3xA5HsdoMkpSl/ekPNlIJElqek75fzpnFOBoVm5rJyeeUH
         w9SZXnUrgLu6rK1u0Y/24scd6xloPCgoNrmvrYjiYecuww1HsLS5Xwbz8SOdC1kq1G5U
         aWvw==
X-Gm-Message-State: APjAAAXZ8YeRtLG0mtRAuLf2uvzIXqQVFlpqaJ2rd7CBO+mK929n90kD
        OAT0DIHYGqc2cqc5a3tPgSjcAvAvLzX1sI31vWk+fA==
X-Google-Smtp-Source: APXvYqzmF34g0nZFr7DF1AKlt1QCmlxH+mSY9VRh9SQu0Ps7iRGt/qgCxg0xMvSqW7uqWDYnhFpJcDIiC4O2o2Zq+AA=
X-Received: by 2002:a05:651c:1072:: with SMTP id y18mr11832537ljm.243.1581608589852;
 Thu, 13 Feb 2020 07:43:09 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Feb 2020 21:12:57 +0530
Message-ID: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
Subject: LKFT: arm x15: mmc1: cache flush error -110
To:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-block@vger.kernel.org, lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

arm beagleboard x15 device failed to boot Linux mainline and
linux-next kernel due
to below error.
This error occurred across all x15 device for these kernel version.

This regression started happening on x15 from this commit onwards (27th Jan)
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git commit: aae1464f46a2403565f75717438118691d31ccf1
  git describe: v5.5-489-gaae1464f46a2


Test output log,
[   37.606241] mmc1: Card stuck being busy! mmc_poll_for_busy
[   37.611850] mmc1: cache flush error -110
[   37.615883] blk_update_request: I/O error, dev mmcblk1, sector
4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
[   37.627387] Aborting journal on device mmcblk1p9-8.
[   37.635448] systemd[1]: Installed transient /etc/machine-id file.
[   37.659283] systemd[1]: Couldn't move remaining userspace
processes, ignoring: Input/output error
[   37.744027] EXT4-fs error (device mmcblk1p9):
ext4_journal_check_start:61: Detected aborted journal
[   37.753322] EXT4-fs (mmcblk1p9): Remounting filesystem read-only
[   37.917486] systemd-gpt-auto-generator[108]: Failed to dissect:
Input/output error
[   37.927825] systemd[104]:
/lib/systemd/system-generators/systemd-gpt-auto-generator failed with
exit status 1.
<>
[   68.856307] mmc1: Card stuck being busy! mmc_poll_for_busy
[   68.861838] mmc1: cache flush error -110
[   68.865812] blk_update_request: I/O error, dev mmcblk1, sector 0 op
0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
<>
[   98.906243] mmc1: Card stuck being busy! mmc_poll_for_busy
[   98.911774] mmc1: cache flush error -110
[   98.915747] blk_update_request: I/O error, dev mmcblk1, sector 0 op
0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
<>
Dependency failed for Serial Getty on ttyS2.
[  128.946258] mmc1: Card stuck being busy! mmc_poll_for_busy
[  128.951786] mmc1: cache flush error -110
[  128.955756] blk_update_request: I/O error, dev mmcblk1, sector 0 op
0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
[FAILED] Failed to start File System Check on Root Device.
See 'systemctl status systemd-fsck-root.service' for details.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Reached target Login Prompts.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Reached target Timers.
[  OK  ] Closed Syslog Socket.
[  OK  ] Started Emergency Shell.
[  129.227328] EXT4-fs error (device mmcblk1p9): ext4_remount:5354:
Abort forced by user
[  OK  ] Reached target Emergency Mode.
[  OK  ] Reached target Sockets.
[FAILED] Failed to start Remount Root and Kernel File Systems.
<>
You are in emergency mode. After logging in, type \"journalctl -xb\" to view
system logs, \"systemctl reboot\" to reboot, \"systemctl default\" or \"exit\"
to boot into default mode.
Press Enter for maintenance
auto-login-action timed out after 874 seconds

ref:
https://lkft.validation.linaro.org/scheduler/job/1137693#L4034
https://lkft.validation.linaro.org/scheduler/job/1158106#L4048
https://lkft.validation.linaro.org/scheduler/job/1137690#L3985
https://lkft.validation.linaro.org/scheduler/job/1137691#L4012
https://lkft.validation.linaro.org/scheduler/job/1137696#L4043
https://lkft.validation.linaro.org/scheduler/job/1137699#L4153

-- 
Linaro LKFT
https://lkft.linaro.org
