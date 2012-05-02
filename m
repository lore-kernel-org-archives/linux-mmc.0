From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: make multiple instances of dw_mci_card_workqueue
Date: Wed, 2 May 2012 10:07:45 +0100
Message-ID: <CAFbHwiSG6Z0aWuZvrydSjY07rgJpAuPx=9tzQDKc7UbaRTnY6A@mail.gmail.com>
References: <1335909456-14020-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1335909456-14020-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@google.com
List-Id: linux-mmc@vger.kernel.org

On Tue, May 1, 2012 at 10:57 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The variable 'dw_mci_card_workqueue' is a global variable shared betw=
een
> multiple instances of the dw_mmc host controller. Due to this, data
> corruption has been noticed when multiple instances of dw_mmc control=
lers
> are actively reading/writing the media. Fix this by adding a instance
> of 'struct workqueue_struct' for each host instance and removing the
> global 'dw_mci_card_workqueue' instance.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 14 ++++++--------
> =A0include/linux/mmc/dw_mmc.h | =A0 =A01 +
> =A02 files changed, 7 insertions(+), 8 deletions(-)

Looks good.

Acked-by: Will Newton <will.newton@imgtec.com>
