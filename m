From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/5] mmc: dw-mmc: fixed the section mismatch in reference
Date: Thu, 23 Aug 2012 13:13:09 +0100
Message-ID: <CAFbHwiSK63g7UQEPb6rPUuhrz=zweL2bbdKicdTKpORxEPhxag@mail.gmail.com>
References: <503614A4.2070801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33907 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932925Ab2HWMNK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 08:13:10 -0400
Received: by qcro28 with SMTP id o28so407879qcr.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 05:13:09 -0700 (PDT)
In-Reply-To: <503614A4.2070801@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Fixed the below message.
>
> WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch in reference from the function dw_mci_probe() to the function .init.text:dw_mci_init_slot()
> The function dw_mci_probe() references
> the function __init dw_mci_init_slot().
> This is often because dw_mci_probe lacks a __init
> annotation or the annotation of dw_mci_init_slot is wrong
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |    4 ++--
>  drivers/mmc/host/dw_mmc.c       |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
