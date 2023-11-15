Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93C433A0
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+RbvBST"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715171FFB
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:52 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5b383b4184fso81118387b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063511; x=1700668311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pylINcL01yD77xhpL+jHM3PYJlt+NwgOinNtm8pq3k=;
        b=B+RbvBST7aI9PFS1iePt1s+nnzVtmQYFsioSVQct/FOX6M+TC5IwFws7nbTpNgOUae
         7AieerAKE8HaKTTqVLTR54rRhRt1SVeb768x/ecwt9tts5IsqQBFlkcwinZ+Ctkw47Xc
         J7MyV3j8djshUGTSuz83pyBUspCRzcrZx5H6TSkWsZAggDRx6Ucm3BNMu1YW1se3vYui
         TXCcvvwEFsVGMjNa/eK06tuAj9sLSPpCSGPW9v47bL5oDi4PC3Ko9YZFxzD+EeTq2T65
         5OOzUMkkZL3KYmr6x0CAVQQ5FsUn5TZIi2A1eVjLdPkR+j9o3s3HoUPFBFKzIZZMXrkz
         6RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063511; x=1700668311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pylINcL01yD77xhpL+jHM3PYJlt+NwgOinNtm8pq3k=;
        b=EjmLHVa6hfBhieL6grub6QaLZQ7XJGCdbLs5kZ+KW0cBobNclh2FYg1vhevuCi3cxK
         Y2d3/0c1zJKgerq1MH4G2arQFW0h8XTYavRG/9ucZJeedsX89VM+Wyg48OUTVZHRTdo6
         JHiOs39m9RrXUhBWeYKa/6LWzJOOXAs+4YY3Z0vn41EQFQtl26t6jW85EZrqn7Qb2Nd8
         PPYhHZ8MB7RaVX2DzvXVCAZsPhNGhheDeJIYGrhJlhbBXH9uVIUGYKzYF1zAqZvCufKG
         XRPEWEbcB0uxHjXYBcC7PWd22qOdJRkUtTcMgWa8LQAXYbM4AlkNlHOu9QO89a6JjNGD
         +Wig==
X-Gm-Message-State: AOJu0Yx+0Rosz4hziZcfxNk1zZB4n3jIY9A5CMWZItmqQ9anCsOUd8jw
	8w045/mOWcVsABKTL3lTGcLh/1ulamdDRG5L6AyadA==
X-Google-Smtp-Source: AGHT+IE25KRtFWaHwm+jpmKSkJDsBeLuZ4Hzg2tjN55Chq6SWsCPVfpnkg/ef4gKEWoWmFCCN7ovHISOzCAa0ugcc0M=
X-Received: by 2002:a0d:f5c3:0:b0:5a8:7cb2:15d0 with SMTP id
 e186-20020a0df5c3000000b005a87cb215d0mr13042799ywf.11.1700063511623; Wed, 15
 Nov 2023 07:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103084720.6886-1-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Nov 2023 16:51:15 +0100
Message-ID: <CAPDyKFrbXAV4-KyA1nXKzLtB8qTq9kX+Vwe0=BcX=-0XSVXK7A@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Asutosh Das <quic_asutoshd@quicinc.com>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Bhavya Kapoor <b-kapoor@ti.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>, 
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, Thierry Reding <thierry.reding@gmail.com>, 
	Aniruddha Tvs Rao <anrao@nvidia.com>, Chun-Hung Wu <chun-hung.wu@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Nov 2023 at 09:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Some issues have been found with CQE error recovery.  Here are some fixes=
.
>
> As of V2, the alternative implementation for the patch from Kornel Dul=C4=
=99ba:
>
>         https://lore.kernel.org/linux-mmc/e7c12e07-7540-47ea-8891-2cec73d=
58df1@intel.com/T/#u
>
> is now included, see patch 6 "mmc: cqhci: Fix task clearing in CQE error
> recovery")
>
> Please also note ->post_disable() seems to be missing from
> cqhci_recovery_start().  It would be good if ->post_disable()
> users could check if this needs attention.
>
>
> Changes in V2:
>
>       mmc: cqhci: Fix task clearing in CQE error recovery
>             New patch
>
>       mmc: cqhci: Warn of halt or task clear failure
>             Add fixes and stable tags
>
>
> Adrian Hunter (6):
>       mmc: block: Do not lose cache flush during CQE error recovery
>       mmc: cqhci: Increase recovery halt timeout
>       mmc: block: Be sure to wait while busy in CQE error recovery
>       mmc: block: Retry commands in CQE error recovery
>       mmc: cqhci: Warn of halt or task clear failure
>       mmc: cqhci: Fix task clearing in CQE error recovery
>
>  drivers/mmc/core/block.c      |  2 ++
>  drivers/mmc/core/core.c       |  9 +++++++--
>  drivers/mmc/host/cqhci-core.c | 44 +++++++++++++++++++++----------------=
------
>  3 files changed, 31 insertions(+), 24 deletions(-)
>
>

Applied for fixes, thanks!

Kind regards
Uffe
