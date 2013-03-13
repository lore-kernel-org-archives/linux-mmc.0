From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: move host->data_offset init earlier
Date: Wed, 13 Mar 2013 23:20:32 +0900
Message-ID: <002401ce1ff5$ec1daf20$c4590d60$%jun@samsung.com>
References: <1363085034-9270-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1363085034-9270-1-git-send-email-james.hogan@imgtec.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday, March 12, 2013, James Hogan wrote:
> host->data_offset is initialised at the end of the probe function
> depending on the VERID register, and is used for PIO operations. Move
> this initialisation earlier, before IRQs or slots are initialised, to be
> sure that PIO won't occur prior to host->data_offset being initialised.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
