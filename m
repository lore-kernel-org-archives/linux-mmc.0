From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmc: mmci: simplify err check in mmci_post_request
Date: Mon, 12 Sep 2011 16:06:08 +0200
Message-ID: <CACRpkdYq1eWCNtQB9BVJ814MU+m6CBRuOLySPpVAiyj2DpJ2vQ@mail.gmail.com>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
	<1314624959-4634-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40259 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab1ILOGI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2011 10:06:08 -0400
Received: by pzk37 with SMTP id 37so6845437pzk.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Sep 2011 07:06:08 -0700 (PDT)
In-Reply-To: <1314624959-4634-3-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh <santosh.shilimkar@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>

On Mon, Aug 29, 2011 at 3:35 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The error condition indicates that mmci_post_request() should cleanup
> after the mmci_pre_request(). In this case the resources allocated by
> device_prep_slave_sg() are freed by calling dmaengine_terminate_all().
> dma_unmap_sg() should always be performed if the host_cookie is set.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
