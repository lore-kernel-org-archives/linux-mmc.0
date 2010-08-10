From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Will the mmc driver stack implement runtime PM support?
Date: Wed, 11 Aug 2010 02:04:12 +0300
Message-ID: <AANLkTinVBp9tjpXLzmB1nky9APW_3tsMn5rC2h+pCGya@mail.gmail.com>
References: <CE761E84DADF2947A4AF22FB8D97A47328E2DD34@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42552 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934000Ab0HJXEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 19:04:34 -0400
Received: by eya25 with SMTP id 25so4136186eya.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 16:04:32 -0700 (PDT)
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A47328E2DD34@shsmsx501.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Yunpeng,

On Mon, Aug 9, 2010 at 1:56 PM, Gao, Yunpeng <yunpeng.gao@intel.com> wr=
ote:
> So, I just curious that is there any works/plan on supporting the run=
time PM APIs for the mmc driver in community? Thanks

Heh. I was just playing with this a bit (in the context of the wl1271
WLAN SDIO device) and am about to post some preliminary patches for
review.

Regards,
Ohad.

>
> Regards,
> Yunpeng
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
