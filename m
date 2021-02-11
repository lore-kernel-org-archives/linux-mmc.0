Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7471964E37
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 12:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBOMrL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhBOMrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2021 07:47:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE18C061786
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2021 04:46:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r21so8692345wrr.9
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2021 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A15rY6Q2dsPIqCz33RJVqDEPuYAVE90BLBpsO2QsoA8=;
        b=dy4ndi0FVQKHpnWLrvojYRRZ7Z0FSDpbqubvH81x2YHRlPHmYbTtqkOTMOnBqutGCj
         BAZ/13UZ7n/rm6PlLTonfpvxq7XptthgeWpF9V4h8L8mXIEd4ZuTgWsEB38bBe8tiZrm
         fEcQxrtunUWIP6miHGn6HGrlsUoR+DdhZKa8vVOznlgZXrHrNWfrq+B6ahocIhdTxWnZ
         Zen4NTCO6qDdWZ7hr3JJDhAWYqYk5N4o7ZQDfteT3Qu5l3rPrujIuOQVWNayyEfb4piz
         sCohCf8iJNLsafqyRuhaDrtaQgvHUZrLWGmPxW95JAiDeK69uoj0yggn1b6hRo82C5y2
         X6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=A15rY6Q2dsPIqCz33RJVqDEPuYAVE90BLBpsO2QsoA8=;
        b=VLUJq3pH4za2CwPTCTyCr0/4aG55XwRkCpsxy7zeIieBu8HjrOm5sxbB1am3y3BKce
         kfCJlreLsOuUAv+tYdtjppVMn+FCW/rhCVqYh63kdyVMNICT6HZRhmwMe9d+8hX+dGiE
         AjToBoBrPySDV6EWzlqlgvoV9eB4Mm8uRPYKHPh9b6gOV52EqjqfMQKz5X6Py78nFIEl
         1A7/IesasB49l9nFBg+qaQjQbvsdjhUEk2qG+AA2Jm0LnEu4JmBMvmc8gjbltUUWOLUh
         Eq0Zg3DwzawQ6IArG9uWfChwWPcTzyVHVtnQTBjQUiqQO6E+9dRDvp1dpsK30r0l5iyd
         7Xww==
X-Gm-Message-State: AOAM532myl9/8CjJmbEWKZLC9rqQ0rqNac7VkpMsu0K7xp2/Nt67aDjv
        u5ouhczftTdoOvLGZlMQHK9VerSg7TJf8WqG
X-Google-Smtp-Source: ABdhPJwBga4tSgNDKfwze/eJGnZcOM3JW+RCuJZb/Vfyqnk6s3PAP8Z6w77iJRe0ND6ZRWRMu5Z5pg==
X-Received: by 2002:a5d:50c8:: with SMTP id f8mr5187435wrt.69.1613393181489;
        Mon, 15 Feb 2021 04:46:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id j71sm25969899wmj.31.2021.02.15.04.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:46:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id ED01A1FF7E;
        Mon, 15 Feb 2021 12:46:19 +0000 (GMT)
User-agent: mu4e 1.5.8; emacs 28.0.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huang Yang <yang.huang@intel.com>,
        Ruchika Gupta <ruchika.gupta@linaro.org>
Subject: RPMB user space ABI
Date:   Thu, 11 Feb 2021 14:07:00 +0000
Message-ID: <87mtwashi4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Last year while I was implementing a virtio-rpmb backend for QEMU I
ended up using patches from the ACRN tree which was based on Thomas'
patches last posted in 2016:

  https://lore.kernel.org/lkml/1478548394-8184-1-git-send-email-tomas.winkl=
er@intel.com/

which I bastardised into a testing tree on a more recent kernel:

  https://git.linaro.org/people/alex.bennee/linux.git/log/?h=3Dtesting/virt=
io-rpmb

The main reason I hacked them around was because the VirtIO spec had
since been finalised and had a very different framing structure. The
original proposed ABI provided for an ioctl which sent JDEC frames to
the underlying device. This was later expanded to support NVME style
frames. Neither of these frame sequences matched the final VirtIO
specification.

It seems to me having the ioctl ABI at this level exposes too many
underlying HW details to user space. With the number of HW devices that
providing RPMB features likely to grow from the current 3 (eMMC/JDEC,
NVME, VirtIO) it seems this ABI should operate at a higher level, e.g.:

      PROGRAM_KEY
      GET_WRITE_COUNTER
      WRITE_DATA
      READ_DATA

and I guess some sort of asynchronous result check?

It would then be for the kernel to take the higher level concepts and
translate them to the final frames required to talk to the actual HW (if
indeed there is some).

Does this seem reasonable? Is this orthogonal to any access to RPMB
partitions that file-systems might want to do?

--=20
Alex Benn=C3=A9e
