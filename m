Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B210A00
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVgdL2ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44387C433C9;
	Thu,  7 Dec 2023 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931897;
	bh=L1TtivioL0Lps3vy6WPsQqR1XcD3JmC00x4u49IX1Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVgdL2kinFybPXfvwdF0P8bEKZTAAsbQBGWfczZMQ+GU2b8rz+nqzmTZAAq6aHvMc
	 rpoWwDa//JVszP3CNaDNv4HbNXooqziBc1krn36s19I6k9Bnhc0KgkPkhZrO7vQgay
	 yTitdxi4x7DZOFyop7tjoXRX9v1RO0GGapzK5U9U=
Date: Thu, 7 Dec 2023 11:14:32 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Ricky Wu <ricky_wu@realtek.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	frank.li@vivo.com, u.kleine-koenig@pengutronix.de,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v6 1/3] misc: rtsx: add to support new card reader
 rts5264 new definition and function
Message-ID: <2023120715-reenact-repose-906c@gregkh>
References: <20231129034856.2001223-1-ricky_wu@realtek.com>
 <20231129034856.2001223-2-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129034856.2001223-2-ricky_wu@realtek.com>

On Wed, Nov 29, 2023 at 11:48:54AM +0800, Ricky Wu wrote:
> in order to support NEW chip rts5264, the definitions of some internal
> registers are define in new file rts5264.h, and some callback functions 
> and the workflow for rts5264 are define in new file rts5264.c
> 
> also add rts5264.o to Makefile
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
> v4: split new definition part up from v3
> ---
>  drivers/misc/cardreader/Makefile  |   2 +-
>  drivers/misc/cardreader/rts5264.c | 886 ++++++++++++++++++++++++++++++
>  drivers/misc/cardreader/rts5264.h | 278 ++++++++++
>  3 files changed, 1165 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/cardreader/rts5264.c
>  create mode 100644 drivers/misc/cardreader/rts5264.h

When building with this change applied, I get lots of build errors.  How
did you test this?

My errors are:

  CC [M]  drivers/misc/cardreader/rts5264.o
drivers/misc/cardreader/rts5264.c: In function ‘rts5264_process_ocp’:
drivers/misc/cardreader/rts5264.c:398:40: error: ‘struct rtsx_pcr’ has no member named ‘ovp_stat’; did you mean ‘ocp_stat’?
  398 |         rts5264_get_ovpstat(pcr, &pcr->ovp_stat);
      |                                        ^~~~~~~~
      |                                        ocp_stat
drivers/misc/cardreader/rts5264.c:402:31: error: ‘struct rtsx_pcr’ has no member named ‘ovp_stat’; did you mean ‘ocp_stat’?
  402 |                         (pcr->ovp_stat & (RTS5264_OVP_NOW | RTS5264_OVP_EVER))) {
      |                               ^~~~~~~~
      |                               ocp_stat
drivers/misc/cardreader/rts5264.c:408:22: error: ‘struct rtsx_pcr’ has no member named ‘ovp_stat’; did you mean ‘ocp_stat’?
  408 |                 pcr->ovp_stat = 0;
      |                      ^~~~~~~~
      |                      ocp_stat
drivers/misc/cardreader/rts5264.c: In function ‘rts5264_extra_init_hw’:
drivers/misc/cardreader/rts5264.c:534:38: error: ‘RTS5264_AUTOLOAD_CFG2’ undeclared (first use in this function); did you mean ‘RTS5264_AUTOLOAD_CFG3’?
  534 |         rtsx_pci_write_register(pcr, RTS5264_AUTOLOAD_CFG2,
      |                                      ^~~~~~~~~~~~~~~~~~~~~
      |                                      RTS5264_AUTOLOAD_CFG3
drivers/misc/cardreader/rts5264.c:534:38: note: each undeclared identifier is reported only once for each function it appears in
drivers/misc/cardreader/rts5264.c:535:25: error: ‘RTS5264_CHIP_RST_N_SEL’ undeclared (first use in this function); did you mean ‘RTS5264_NON_XTAL_SEL’?
  535 |                         RTS5264_CHIP_RST_N_SEL, 0);
      |                         ^~~~~~~~~~~~~~~~~~~~~~
      |                         RTS5264_NON_XTAL_SEL
drivers/misc/cardreader/rts5264.c:538:38: error: ‘CDGW’ undeclared (first use in this function)
  538 |         rtsx_pci_write_register(pcr, CDGW, 0xFF, 0x01);
      |                                      ^~~~
drivers/misc/cardreader/rts5264.c: In function ‘rts5264_init_params’:
drivers/misc/cardreader/rts5264.c:883:51: error: ‘SD_OVP_INT_EN’ undeclared (first use in this function); did you mean ‘SD_OCP_INT_EN’?
  883 |         hw_param->interrupt_en |= (SD_OC_INT_EN | SD_OVP_INT_EN);
      |                                                   ^~~~~~~~~~~~~
      |                                                   SD_OCP_INT_EN
make[5]: *** [scripts/Makefile.build:243: drivers/misc/cardreader/rts5264.o] Error 1



Remember, each commit can not break the build.  Please fix up this series to
build properly at each commit.

thanks,

greg k-h
