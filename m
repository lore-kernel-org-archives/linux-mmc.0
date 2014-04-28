From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/2] mmc: rtsx: modify error handle and remove
 smatchwarnings
Date: Mon, 28 Apr 2014 15:40:01 +0300
Message-ID: <20140428124001.GV26890@mwanda>
References: <cover.1395824147.git.micky_ching@realsil.com.cn>
 <2f71c814a30f26a0550f1132bd53a682338c44d3.1395824147.git.micky_ching@realsil.com.cn>
 <535E3D8D.3000309@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <535E3D8D.3000309@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: micky <micky_ching@realsil.com.cn>
Cc: ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 28, 2014 at 07:37:49PM +0800, micky wrote:
> Hi Chris and Ulf,
> 
> This patch is denpend on commit c42deffd5b53c9e583d83c7964854ede2f12410d.
> <mmc: rtsx: add support for pre_req and post_req>, and we discard
> the previous commit.
> we want discard this patch also(it it now in linux-next), need I
> send another patch to
> revert or it will be discard automatically?

Send a patch to revert this patch as well.  You should have sent both
at the same time so it didn't cause breakage...

regards,
dan carpenter
